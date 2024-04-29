//
//  notification.swift
//  eros
//
//  Created by iOS Lab on 10/02/24.
//

import Foundation

import SwiftUI
import UserNotifications

struct NotificationView: View {
    @State private var showNotificationPrompt = false
    @State private var isAuthenticated = false
    @State private var badgeCount = 0

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Vitela la chupa")
        }
        .padding()
        .onAppear {
            // Check if notifications are enabled
            NotificationManager.shared.askPermission { success in
                if !success {
                    // If notifications are not enabled, show the prompt
                    self.showNotificationPrompt = true
                }
            }
            
            // Simulate authentication success
            self.isAuthenticated = true
        }
        .alert(isPresented: $showNotificationPrompt) {
            Alert(
                title: Text("Enable Notifications?"),
                message: Text("Would you like to enable notifications to receive important updates?"),
                primaryButton: .default(Text("Enable"), action: {
                    // Handle enabling notifications
                    NotificationManager.shared.askPermission { success in
                        if success {
                            // If notifications are enabled, authenticate the player
                            self.isAuthenticated = true
                        }
                    }
                }),
                secondaryButton: .cancel(Text("Not Now"))
            )
        }
        .onChange(of: isAuthenticated) { isAuthenticated in
            if isAuthenticated {
                // Send notification when authenticated
                NotificationManager.shared.sendNotification()
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            // Reset badge count when the app is opened
            UIApplication.shared.applicationIconBadgeNumber = 0
            self.badgeCount = 0
        }
        .onReceive(NotificationCenter.default.publisher(for: NotificationManager.notificationReceivedNotification)) { _ in
            // Update badge count on the main thread
            DispatchQueue.main.async {
                self.badgeCount += 1
                UIApplication.shared.applicationIconBadgeNumber = self.badgeCount
            }
        }
    }
}

// Dummy NotificationManager for demonstration purposes
class NotificationManager {
    static let shared = NotificationManager()
    static let notificationReceivedNotification = Notification.Name("NotificationReceived")

    private init() {} // Private initializer for singleton

    func askPermission(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { success, error in
            if success {
                print("ACCESS GRANTED")
                completion(true)
            } else if let error = error {
                print(error.localizedDescription)
                completion(false)
            }
        }
    }

    func sendNotification() {
        let content = UNMutableNotificationContent()
        content.title = "CultiveAR"
        content.body = "Notification Body"
        content.sound = UNNotificationSound.default

        // Set threadIdentifier to group notifications
        content.threadIdentifier = "grouped_notifications"

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 30, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error adding notification: \(error.localizedDescription)")
            } else {
                NotificationCenter.default.post(name: NotificationManager.notificationReceivedNotification, object: nil)
            }
        }
    }
}

struct ContentView_Previews2: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
