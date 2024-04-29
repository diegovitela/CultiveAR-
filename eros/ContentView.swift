//
//  ContentView.swift
//  eros
//
//  Created by iOS Lab on 01/02/24.
//

import SwiftUI
import UserNotifications

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var showNotificationPrompt = false
    let notificationInterval: TimeInterval = 10000

    var body: some View {
        ZStack {
            Color(hex: "4CAF50") // Asegúrate de que el color hex se convierta correctamente
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                Image("planta1") // Asegúrate de que esta imagen exista en tus assets
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                
                Spacer()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.showNotificationPrompt = true
            }
        }
        .fullScreenCover(isPresented: $isActive, content: ContentView.init)
        .alert(isPresented: $showNotificationPrompt) {
            Alert(
                title: Text("Activar notificaciones"),
                message: Text("Por favor, activa las notificaciones para disfrutar de la mejor experiencia."),
                primaryButton: .default(Text("Activar"), action: {
                    self.isActive = true
                    scheduleNotification()
                }),
                secondaryButton: .cancel(Text("Cancelar"), action: {

                })
            )
        }
    }
    
    func scheduleNotification() {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                if granted {
                    DispatchQueue.main.async {
                        // Configurar y agregar la solicitud de notificación solo si se concede el permiso
                        let content = UNMutableNotificationContent()
                        content.title = "¡Es hora de regar tu planta!"
                        content.sound = .default
                        
                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: self.notificationInterval, repeats: true)
                        
                        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                        
                        UNUserNotificationCenter.current().add(request) { error in
                            if let error = error {
                                print("Error al programar la notificación: \(error.localizedDescription)")
                            }
                        }
                    }
                } else if let error = error {
                    print("Permiso no concedido: \(error.localizedDescription)")
                }
            }
        }
}




struct ContentView: View {
    
    @State private var levels: [Level] = [
        Level(id: 1, imageName: "frijol2", isLocked: false, width: 100, height: 100),
        Level(id: 2, imageName: "Uvas2", isLocked: false, width: 100, height: 100),
        Level(id: 3, imageName: "lechuga2", isLocked: false, width: 100, height: 100),
        Level(id: 4, imageName: "verde", isLocked: false, width: 100, height: 100),
        Level(id: 5, imageName: "cebolla", isLocked: false, width: 100, height: 100),
        Level(id: 6, imageName: "rabano", isLocked: false, width: 100, height: 100),
        Level(id: 7, imageName: "tomate", isLocked: false, width: 100, height: 100),
        Level(id: 8, imageName: "calabaza", isLocked: false, width: 100, height: 100),
        Level(id: 9, imageName: "pepino", isLocked: false, width: 100, height: 100)
    ]

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image("planta1").resizable().scaledToFit().frame(width: 150, height: 150)
                Text("CULTIVOS").font(.title).fontWeight(.bold).foregroundColor(.white).padding()
                Spacer()
            }.background(Color(hex: "4CAF50"))
            
            Spacer()
            
            VStack {
                HStack {
                    ForEach(levels.prefix(5)) { level in
                        LevelButton(level: level)
                    }
                }
                
                HStack {
                    ForEach(levels.suffix(4)) { level in
                        LevelButton(level: level)
                    }
                }
            }
            
            Spacer()
        }.frame(maxWidth: .infinity, maxHeight: .infinity).background(Color(hex: "C8E6C9"))
    }
}

struct FrijolMessageView: View {
    @State private var debeNavegarAFrijolote = false // Estado para controlar la navegación
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode> // Acceso al modo de presentación para regresar

    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.96, green: 0.96, blue: 0.86) // Fondo beige muy claro
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        Image("frijol")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 400, height: 400)
                        
                        VStack {
                            Text("Frijoles")
                                .font(.system(size: 50, weight: .bold))
                                .foregroundColor(.brown)
                            
                            NavigationLink(destination: FrijoloteView(), isActive: $debeNavegarAFrijolote) {
                                Button(action: {
                                    self.debeNavegarAFrijolote = true // Activa la navegación a FrijoloteView
                                }) {
                                    Text("Inicio")
                                        .font(.title)
                                        .foregroundColor(.white)
                                        .frame(width: 190, height: 60)
                                        .background(Color.black)
                                        .cornerRadius(30)
                                }
                            }
                            .padding(.top, 20)
                        }
                        Spacer()
                    }
                    Spacer()
                }
                .padding()
            }
            .overlay(
                VStack {
                    HStack {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "arrow.left")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(Color.brown)
                        }
                        .padding(.horizontal, 10) // Mantenemos el padding horizontal
                        .padding(.top, 30) // Aumentamos el padding superior para subir la flecha
                        Spacer()
                    }
                    Spacer()
                },
                alignment: .topLeading
            )
            .navigationBarHidden(true)
        }
    }
}





struct FrijoloteView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var debeNavegar = false
    
    let materiales = ["Recipiente", "Algodón", "Frijol", "Maceta", "Tierra", "Agua"]
    let textColor = Color(.brown)
    
    var body: some View {
        ZStack { // Usar ZStack para permitir la superposición de elementos
            VStack(alignment: .leading) {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(textColor)
                        Spacer()
                    }
                    .padding(.horizontal, 10)
                    .frame(height: 50)
                }
                .padding(.top, 50)
                .padding(.leading, 10)
                .background(Color(red: 0.96, green: 0.96, blue: 0.86))
                .cornerRadius(15)
                
                Text("Materiales")
                    .font(.system(size: 100, weight: .bold))
                    .foregroundColor(textColor)
                    .padding(.leading, 10)
                    .padding(.top)
                
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(materiales, id: \.self) { material in
                        HStack {
                            Text("•")
                                .font(.title)
                                .foregroundColor(textColor)
                            Text(material)
                                .font(.system(size: 50, weight: .regular))
                                .foregroundColor(Color(.brown).opacity(0.7))
                        }
                        .padding(.leading, 60)
                    }
                }
                .padding(.leading, 60)
                
                Spacer()
                
                NavigationLink(destination: OtraPagina(), isActive: $debeNavegar) {
                    EmptyView()
                }
                
                Button(action: {
                    self.debeNavegar = true
                }) {
                    Text("Siguiente")
                        .font(.system(size: 30)) // Removido el weight: .bold para un aspecto no grueso
                        .foregroundColor(Color.white)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(30)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.bottom, 20)
                .padding(.trailing, 20)
            }
            
            HStack {
                Spacer()
                VStack {
                    Spacer()
                    Image("carrito3")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 600, height: 600)
                    Spacer()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0.96, green: 0.96, blue: 0.86))
        .edgesIgnoringSafeArea(.all)
        .navigationBarBackButtonHidden(true)
    }
}












struct OtraPagina: View {
    @State private var isButtonPressed = false // Estado para controlar la navegación a ARViewContainer
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode> // Acceso al modo de presentación para regresar

    var body: some View {
        ZStack {
            Color(red: 0.96, green: 0.96, blue: 0.86)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(Color(.brown))
                    }
                    .padding(.horizontal, 10)
                    .padding(.top, 60)
                    Spacer()
                }
                Spacer()
            }
            
            Text("Toma un recipiente")
                .font(.system(size: 100, weight: .bold))
                .foregroundColor(.green)
                .padding()

            // Colocando el botón "cubo" en la esquina inferior izquierda
            VStack {
                Spacer()
                HStack {
                    Button(action: {
                        self.isButtonPressed = true
                    }) {
                        Image("cubo")
                            .resizable()
                            .frame(width: 100, height: 100)
                    }
                    .padding(20)
                    Spacer() // Esto empujará el botón del cubo hacia la izquierda
                }
            }

            // Botón en la esquina inferior derecha para navegar a AlgodonView
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    NavigationLink(destination: AlgodonView()) {
                        Text("Siguiente")
                            .font(.system(size: 30)) // Removido el weight: .bold para un aspecto no grueso
                            .foregroundColor(Color.white)
                            .padding()
                            .background(Color.black)
                            .cornerRadius(30)
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true) // Oculta el botón de retroceso estándar
        .overlay(
            VStack {
                HStack {
                    Text("Paso")
                        .font(.system(size: 100, weight: .bold))
                        .foregroundColor(Color(.brown))
                    Image("uno")
                        .resizable()
                        .frame(width: 100, height: 100)
                }
                .padding(.horizontal, 10)
                .padding(.top, 150) // Aumentamos el padding superior para subir la flecha
                Spacer()
            }
            .padding(.leading, 20) // Agregamos padding izquierdo para separar el texto de los otros elementos
            .offset(x: 0, y: -20), // Ajustamos la posición vertical de la imagen
            alignment: .topLeading
        )
        .background(Color(red: 0.96, green: 0.96, blue: 0.86))
        .edgesIgnoringSafeArea(.all)
        .sheet(isPresented: $isButtonPressed) {
            ARViewContainer2() // Asegura que esta vista esté definida en tu proyecto
        }
    }
}







struct AlgodonView: View {
    @State private var isButtonPressed = false // Estado para controlar la navegación a ARViewContainer
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode> // Acceso al modo de presentación para regresar

    var body: some View {
        ZStack {
            Color(red: 0.96, green: 0.96, blue: 0.86)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(Color(.brown))
                    }
                    .padding(.horizontal, 10)
                    .padding(.top, 60)
                    Spacer()
                }
                Spacer()
            }
            
           
            VStack {
                            Text("Coloca algodón")
                                .font(.system(size: 100, weight: .bold))
                                .foregroundColor(.green)
                                .padding()
                            
                            Text("El algodón dentro del recipiente nos ayudará a proteger el frijol y a mantener el agua que hidratará el frijol.")
                                .font(.system(size: 30))
                                .foregroundColor(.black) // Letras en negro
                                .padding(.top, 20) // Ajusta el espaciado superior
                                .multilineTextAlignment(.center)
                        }
            
            

            // Colocando el botón "cubo" en la esquina inferior izquierda
            VStack {
                Spacer()
                HStack {
                    Button(action: {
                        self.isButtonPressed = true
                    }) {
                        Image("cubo")
                            .resizable()
                            .frame(width: 100, height: 100)
                    }
                    .padding(20)
                    Spacer() // Esto empujará el botón del cubo hacia la izquierda
                }
            }

            // Botón en la esquina inferior derecha para navegar a AlgodonView
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    NavigationLink(destination: ColocarView()) {
                        Text("Siguiente")
                            .font(.system(size: 30)) // Removido el weight: .bold para un aspecto no grueso
                            .foregroundColor(Color.white)
                            .padding()
                            .background(Color.black)
                            .cornerRadius(30)
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true) // Oculta el botón de retroceso estándar
        .overlay(
            VStack {
                HStack {
                    Text("Paso")
                        .font(.system(size: 100, weight: .bold))
                        .foregroundColor(Color(.brown))
                    Image("dos")
                        .resizable()
                        .frame(width: 125, height: 100)
                }
                .padding(.horizontal, 10)
                .padding(.top, 150) // Aumentamos el padding superior para subir la flecha
                Spacer()
            }
            .padding(.leading, 20) // Agregamos padding izquierdo para separar el texto de los otros elementos
            .offset(x: 0, y: -20), // Ajustamos la posición vertical de la imagen
            alignment: .topLeading
        )
        .background(Color(red: 0.96, green: 0.96, blue: 0.86))
        .edgesIgnoringSafeArea(.all)
        .sheet(isPresented: $isButtonPressed) {
            ARViewContainer3() // Asegura que esta vista esté definida en tu proyecto
        }
    }
}


struct ColocarView: View {
    @State private var isButtonPressed = false // Estado para controlar la navegación a ARViewContainer
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode> // Acceso al modo de presentación para regresar

    var body: some View {
        ZStack {
            Color(red: 0.96, green: 0.96, blue: 0.86)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(Color(.brown))
                    }
                    .padding(.horizontal, 10)
                    .padding(.top, 60)
                    Spacer()
                }
                Spacer()
            }
            
            Text("Coloca el frijol")
                .font(.system(size: 100, weight: .bold))
                .foregroundColor(.green)
                .padding()

            // Colocando el botón "cubo" en la esquina inferior izquierda
            VStack {
                Spacer()
                HStack {
                    Button(action: {
                        self.isButtonPressed = true
                    }) {
                        Image("cubo")
                            .resizable()
                            .frame(width: 100, height: 100)
                    }
                    .padding(20)
                    Spacer()
                }
            }

            // Botón en la esquina inferior derecha para navegar a AlgodonView
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    NavigationLink(destination: FinalView()) {
                        Text("Siguiente")
                            .font(.system(size: 30)) // Removido el weight: .bold para un aspecto no grueso
                            .foregroundColor(Color.white)
                            .padding()
                            .background(Color.black)
                            .cornerRadius(30)
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true) // Oculta el botón de retroceso estándar
        .overlay(
            VStack {
                HStack {
                    Text("Paso")
                        .font(.system(size: 100, weight: .bold))
                        .foregroundColor(Color(.brown))
                    Image("tres")
                        .resizable()
                        .frame(width: 125, height: 110)
                }
                .padding(.horizontal, 10)
                .padding(.top, 150) // Aumentamos el padding superior para subir la flecha
                Spacer()
            }
            .padding(.leading, 20) // Agregamos padding izquierdo para separar el texto de los otros elementos
            .offset(x: 0, y: -20), // Ajustamos la posición vertical de la imagen
            alignment: .topLeading
        )
        .background(Color(red: 0.96, green: 0.96, blue: 0.86))
        .edgesIgnoringSafeArea(.all)
        .sheet(isPresented: $isButtonPressed) {
            ARViewContainer4() // Asegura que esta vista esté definida en tu proyecto
        }
    }
}


struct FinalView: View {
    @State private var isButtonPressed = false // Estado para controlar la navegación a ARViewContainer
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode> // Acceso al modo de presentación para regresar
    
    var body: some View {
        ZStack {
            Color(red: 0.96, green: 0.96, blue: 0.86)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(Color(.brown))
                    }
                    .padding(.horizontal, 10)
                    .padding(.top, 60)
                    Spacer()
                }
                Spacer()
            }
            
            VStack {
                Text("Vierte Agua")
                    .font(.system(size: 100, weight: .bold))
                    .foregroundColor(.green)
                    .padding()
                
                Text("Debemos hidratar con poca agua el frijol duranten 9 dias ")
                    .font(.system(size: 30))
                    .foregroundColor(.black) // Letras en negro
                    .padding(.top, 20) // Ajusta el espaciado superior
                    .multilineTextAlignment(.center)
            }
            
            // Colocando el botón "cubo" en la esquina inferior izquierda
            VStack {
                Spacer()
                HStack {
                    Button(action: {
                        self.isButtonPressed = true
                    }) {
                        Image("cubo")
                            .resizable()
                            .frame(width: 100, height: 100)
                    }
                    .padding(20)
                    Spacer() // Esto empujará el botón del cubo hacia la izquierda
                }
            }
            
            // Botón en la esquina inferior derecha para navegar a la siguiente vista
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    NavigationLink(destination: SiguienteView()) {
                        Text("Siguiente")
                            .font(.system(size: 30)) // Removido el weight: .bold para un aspecto no grueso
                            .foregroundColor(Color.white)
                            .padding()
                            .background(Color.black)
                            .cornerRadius(30)
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true) // Oculta el botón de retroceso estándar
        .overlay(
            VStack {
                HStack {
                    Text("Paso")
                        .font(.system(size: 100, weight: .bold))
                        .foregroundColor(Color(.brown))
                    Image("cuatro")
                        .resizable()
                        .frame(width: 100, height: 100)
                }
                .padding(.horizontal, 10)
                .padding(.top, 150) // Aumentamos el padding superior para subir la flecha
                Spacer()
            }
            .padding(.leading, 20) // Agregamos padding izquierdo para separar el texto de los otros elementos
            .offset(x: 0, y: -20), // Ajustamos la posición vertical de la imagen
            alignment: .topLeading
        )
        .background(Color(red: 0.96, green: 0.96, blue: 0.86))
        .edgesIgnoringSafeArea(.all)
        .sheet(isPresented: $isButtonPressed) {
            ARViewContainer5() // Asegura que esta vista esté definida en tu proyecto
        }
    }
}


struct SiguienteView: View {
    @State private var isButtonPressed = false // Estado para controlar la navegación a ARViewContainer
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode> // Acceso al modo de presentación para regresar
    
    var body: some View {
        ZStack {
            Color(red: 0.96, green: 0.96, blue: 0.86)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(Color(.brown))
                    }
                    .padding(.horizontal, 10)
                    .padding(.top, 60)
                    Spacer()
                }
                Spacer()
            }
            
            VStack {
                Text("Espera a que germine")
                    .font(.system(size: 100, weight: .bold))
                    .foregroundColor(.green)
                    .padding()
                
            }
            
            // Colocando el botón "cubo" en la esquina inferior izquierda
            VStack {
                Spacer()
                HStack {
                    Button(action: {
                        self.isButtonPressed = true
                    }) {
                        Image("cubo")
                            .resizable()
                            .frame(width: 100, height: 100)
                    }
                    .padding(20)
                    Spacer() // Esto empujará el botón del cubo hacia la izquierda
                }
            }
            
            // Botón en la esquina inferior derecha para navegar a la siguiente vista
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    NavigationLink(destination: TransplantarView()) {
                        Text("Siguiente")
                            .font(.system(size: 30)) // Removido el weight: .bold para un aspecto no grueso
                            .foregroundColor(Color.white)
                            .padding()
                            .background(Color.black)
                            .cornerRadius(30)
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true) // Oculta el botón de retroceso estándar
        .overlay(
            VStack {
                HStack {
                    Text("Paso")
                        .font(.system(size: 100, weight: .bold))
                        .foregroundColor(Color(.brown))
                    Image("Cinco2")
                        .resizable()
                        .frame(width: 110, height: 110)
                }
                .padding(.horizontal, 10)
                .padding(.top, 150) // Aumentamos el padding superior para subir la flecha
                Spacer()
            }
            .padding(.leading, 20) // Agregamos padding izquierdo para separar el texto de los otros elementos
            .offset(x: 0, y: -20), // Ajustamos la posición vertical de la imagen
            alignment: .topLeading
        )
        .background(Color(red: 0.96, green: 0.96, blue: 0.86))
        .edgesIgnoringSafeArea(.all)
        .sheet(isPresented: $isButtonPressed) {
            ARViewContainer6() // Asegura que esta vista esté definida en tu proyecto
        }
    }
}


struct TransplantarView: View {
    @State private var isButtonPressed = false // Estado para controlar la navegación a ARViewContainer
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode> // Acceso al modo de presentación para regresar
    
    var body: some View {
        ZStack {
            Color(red: 0.96, green: 0.96, blue: 0.86)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(Color(.brown))
                    }
                    .padding(.horizontal, 10)
                    .padding(.top, 60)
                    Spacer()
                }
                Spacer()
            }
            
            VStack {
                Text("Transplanta tu planta")
                    .font(.system(size: 100, weight: .bold))
                    .foregroundColor(.green)
                    .padding()
                
                Text("Cambia tu planta a una maseta  ")
                    .font(.system(size: 30))
                    .foregroundColor(.black) // Letras en negro
                    .padding(.top, 20) // Ajusta el espaciado superior
                    .multilineTextAlignment(.center)
            }
            
            // Colocando el botón "cubo" en la esquina inferior izquierda
            VStack {
                Spacer()
                HStack {
                    Button(action: {
                        self.isButtonPressed = true
                    }) {
                        Image("cubo")
                            .resizable()
                            .frame(width: 100, height: 100)
                    }
                    .padding(20)
                    Spacer() // Esto empujará el botón del cubo hacia la izquierda
                }
            }
            
            // Botón en la esquina inferior derecha para navegar a la siguiente vista
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    NavigationLink(destination:  MasetaView()) {
                        Text("Siguiente")
                            .font(.system(size: 30)) // Removido el weight: .bold para un aspecto no grueso
                            .foregroundColor(Color.white)
                            .padding()
                            .background(Color.black)
                            .cornerRadius(30)
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true) // Oculta el botón de retroceso estándar
        .overlay(
            VStack {
                HStack {
                    Text("Paso")
                        .font(.system(size: 100, weight: .bold))
                        .foregroundColor(Color(.brown))
                    Image("seis")
                        .resizable()
                        .frame(width: 100, height: 100)
                }
                .padding(.horizontal, 10)
                .padding(.top, 150) // Aumentamos el padding superior para subir la flecha
                Spacer()
            }
            .padding(.leading, 20) // Agregamos padding izquierdo para separar el texto de los otros elementos
            .offset(x: 0, y: -20), // Ajustamos la posición vertical de la imagen
            alignment: .topLeading
        )
        .background(Color(red: 0.96, green: 0.96, blue: 0.86))
        .edgesIgnoringSafeArea(.all)
        .sheet(isPresented: $isButtonPressed) {
            ARViewContainer7() // Asegura que esta vista esté definida en tu proyecto
        }
    }
}


struct MasetaView: View{
@State private var isButtonPressed = false // Estado para controlar la navegación a ARViewContainer
@Environment(\.presentationMode) var presentationMode: Binding<PresentationMode> // Acceso al modo de presentación para regresar

var body: some View {
    ZStack {
        Color(red: 0.96, green: 0.96, blue: 0.86)
            .edgesIgnoringSafeArea(.all)
        
        VStack {
            HStack {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color(.brown))
                }
                .padding(.horizontal, 10)
                .padding(.top, 60)
                Spacer()
            }
            Spacer()
        }
        
        VStack {
            Text("Resultado Final")
                .font(.system(size: 100, weight: .bold))
                .foregroundColor(.green)
                .padding()
            
            Text("Entra al logo de AR para ver el resultado final de tu cultivo ")
                .font(.system(size: 30))
                .foregroundColor(.black) // Letras en negro
                .padding(.top, 20) // Ajusta el espaciado superior
                .multilineTextAlignment(.center)
        }
        
        // Colocando el botón "cubo" en la esquina inferior izquierda
        VStack {
            Spacer()
            HStack {
                Button(action: {
                    self.isButtonPressed = true
                }) {
                    Image("cubo")
                        .resizable()
                        .frame(width: 100, height: 100)
                }
                .padding(20)
                Spacer() // Esto empujará el botón del cubo hacia la izquierda
            }
        }
        
        // Botón en la esquina inferior derecha para navegar a la siguiente vista
        VStack {
            Spacer()
            HStack {
                Spacer()
                NavigationLink(destination: FINALView()) {
                    Text("Siguiente")
                        .font(.system(size: 30)) // Removido el weight: .bold para un aspecto no grueso
                        .foregroundColor(Color.white)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(30)
                }
                .padding()
            }
        }
    }
    .navigationBarTitle("", displayMode: .inline)
    .navigationBarHidden(true)
    .navigationBarBackButtonHidden(true) // Oculta el botón de retroceso estándar
    .overlay(
        VStack {
            HStack {
                Text("Paso")
                    .font(.system(size: 100, weight: .bold))
                    .foregroundColor(Color(.brown))
                Image("siete")
                    .resizable()
                    .frame(width: 100, height: 100)
            }
            .padding(.horizontal, 10)
            .padding(.top, 150) // Aumentamos el padding superior para subir la flecha
            Spacer()
        }
        .padding(.leading, 20) // Agregamos padding izquierdo para separar el texto de los otros elementos
        .offset(x: 0, y: -20), // Ajustamos la posición vertical de la imagen
        alignment: .topLeading
    )
    .background(Color(red: 0.96, green: 0.96, blue: 0.86))
    .edgesIgnoringSafeArea(.all)
    .sheet(isPresented: $isButtonPressed) {
        ARViewContainer8() // Asegura que esta vista esté definida en tu proyecto
    }
}
}


struct FINALView: View{
@State private var isButtonPressed = false // Estado para controlar la navegación a ARViewContainer
@Environment(\.presentationMode) var presentationMode: Binding<PresentationMode> // Acceso al modo de presentación para regresar

var body: some View {
    ZStack {
        Color(red: 0.96, green: 0.96, blue: 0.86)
            .edgesIgnoringSafeArea(.all)
        
        VStack {
            HStack {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color(.brown))
                }
                .padding(.horizontal, 10)
                .padding(.top, 60)
                Spacer()
            }
            Spacer()
        }
        
        VStack {
            Text("!FELICIDADES!")
                .font(.system(size: 100, weight: .bold))
                .foregroundColor(.green)
                .padding()
            
            Text("Los pasos han terminado, pero el camino aún es largo")
                .font(.system(size: 50, weight: .heavy))
                .foregroundColor(Color.brown)
                .padding(.top, 20)
                .multilineTextAlignment(.center)

    
            
            Text("Presiona el boton de Finalizar para empezar con tu siguiente proyecto ")
                .font(.system(size: 30))
                .foregroundColor(.black) // Letras en negro
                .padding(.top, 20) // Ajusta el espaciado superior
                .multilineTextAlignment(.center)

        }
        
        VStack {
            Spacer()
            HStack {
                Button(action: {
                    self.isButtonPressed = true
                }) {
                    Image("")
                        .resizable()
                        .frame(width: 100, height: 100)
                }
                .padding(20)
                Spacer()
            }
        }
        
        VStack {
            Spacer()
            HStack {
                Spacer()
                NavigationLink(destination: UltimoView()) {
                    Text("Finalizar")
                        .font(.system(size: 30))
                        .foregroundColor(Color.white)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(30)
                }
                .padding()
            }
        }
    }
    .navigationBarTitle("", displayMode: .inline)
    .navigationBarHidden(true)
    .navigationBarBackButtonHidden(true)
    .overlay(
        VStack {
            HStack {
                Text("")
                    .font(.system(size: 100, weight: .bold))
                    .foregroundColor(Color(.brown))
                Image("")
                    .resizable()
                    .frame(width: 100, height: 100)
            }
            .padding(.horizontal, 10)
            .padding(.top, 150)
            Spacer()
        }
        .padding(.leading, 20) // Agregamos padding izquierdo para separar el texto de los otros elementos
        .offset(x: 0, y: -20), // Ajustamos la posición vertical de la imagen
        alignment: .topLeading
    )
    .background(Color(red: 0.96, green: 0.96, blue: 0.86))
    .edgesIgnoringSafeArea(.all)
    .sheet(isPresented: $isButtonPressed) {
        ARViewContainer8() // Asegura que esta vista esté definida en tu proyecto
    }
}
}

struct UltimoView: View {
    @State private var isFrijolButtonPressed = false
        @State private var isUvasButtonPressed = false
    
    
    @State private var levels: [Level] = [
        Level(id: 1, imageName: "frijol2", isLocked: false, width: 100, height: 100),
        Level(id: 2, imageName: "Uvas8", isLocked: false, width: 100, height: 100),
        Level(id: 3, imageName: "lechuga2", isLocked: false, width: 100, height: 100),
        Level(id: 4, imageName: "verde", isLocked: false, width: 100, height: 100),
        Level(id: 5, imageName: "cebolla", isLocked: false, width: 100, height: 100),
        Level(id: 6, imageName: "rabano", isLocked: false, width: 100, height: 100),
        Level(id: 7, imageName: "tomate", isLocked: false, width: 100, height: 100),
        Level(id: 8, imageName: "calabaza", isLocked: false, width: 100, height: 100),
        Level(id: 9, imageName: "pepino", isLocked: false, width: 100, height: 100)
    ]

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image("planta1").resizable().scaledToFit().frame(width: 150, height: 150)
                Text("CULTIVOS").font(.title).fontWeight(.bold).foregroundColor(.white).padding()
                Spacer()
            }.background(Color(hex: "4CAF50"))

            Spacer()

            VStack {
                HStack {
                    ForEach(levels.prefix(5)) { level in
                        LevelButton2(level: level)
                    }
                }

                HStack {
                    ForEach(levels.suffix(4)) { level in
                        LevelButton2(level: level)
                    }
                }
            }

            Spacer()
        }.frame(maxWidth: .infinity, maxHeight: .infinity).background(Color(hex: "C8E6C9"))
            .navigationBarBackButtonHidden(true)
            .fullScreenCover(isPresented: $isUvasButtonPressed){
                EmptyView()
            }
    }
}

struct LevelButton2: View {
    @State private var isFrijolButtonPressed = false
    @State private var isUvasButtonPressed = false
    let level: Level

    var body: some View {
        Button(action: {
            // Determina cuál botón fue presionado basado en el nombre de la imagen
            switch level.imageName {
            case "frijol2":
                self.isFrijolButtonPressed = true
            case "Uvas8":
                self.isUvasButtonPressed = true
            default:
                break
            }
        }) {
            ZStack {
                Image(level.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: level.width, height: level.height)

                // Si el nombre de la imagen es "frijol2", superponemos la imagen "paloma"
                if level.imageName == "frijol2" {
                    Image("paloma") // Asegúrate de tener una imagen "paloma" en tus assets
                        .resizable()
                        .scaledToFit()
                        .frame(width: level.width / 2, height: level.height / 2) // Ajusta el tamaño según lo necesites
                        .opacity(0.8) // Ajusta la opacidad si es necesario
                }
            }
            .padding(5)
        }
        .disabled(level.isLocked)
        // Maneja la navegación para "frijol2"
        .fullScreenCover(isPresented: $isFrijolButtonPressed, content: {
            // Aquí colocas la vista a la que quieres navegar para "frijol2"
            ListoView() // Cambia ListoView() por la vista correspondiente
        })
        // Maneja la navegación para "Uvas8"
        .fullScreenCover(isPresented: $isUvasButtonPressed, content: {
            // Aquí colocas la vista a la que quieres navegar para "Uvas8"
            UvasView() // Cambia UvasView() por la vista correspondiente
        })
    }
}




struct ListoView: View {
    @State private var isButtonPressed = false // Estado para controlar la navegación a ARViewContainer
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode> // Acceso al modo de presentación para regresar

    var body: some View {
        ZStack {
            Color(red: 0.96, green: 0.96, blue: 0.86)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(Color(.brown))
                    }
                    .padding(.horizontal, 10)
                    .padding(.top, 60)
                    Spacer()
                }
                Spacer()
            }
            
           
            VStack {
                            Text("Nivel completado")
                                .font(.system(size: 100, weight: .bold))
                                .foregroundColor(.green)
                                .padding()
                            
                            Text("Si quieres volver a hacerlo puedes ver la animacion en AR para ver todos los pasos ")
                                .font(.system(size: 30))
                                .foregroundColor(.black) // Letras en negro
                                .padding(.top, 20) // Ajusta el espaciado superior
                                .multilineTextAlignment(.center)
                        }
            
            

            // Colocando el botón "cubo" en la esquina inferior izquierda
            VStack {
                Spacer()
                HStack {
                    Button(action: {
                        self.isButtonPressed = true
                    }) {
                        Image("cubo")
                            .resizable()
                            .frame(width: 100, height: 100)
                    }
                    .padding(20)
                    Spacer() // Esto empujará el botón del cubo hacia la izquierda
                }
            }

            // Botón en la esquina inferior derecha para navegar a AlgodonView
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    NavigationLink(destination: ColocarView()) {
                        Text("")
                        
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true) // Oculta el botón de retroceso estándar
        .overlay(
            VStack {
                HStack {
                    Text("CultivAR")
                        .font(.system(size: 100, weight: .bold))
                        .foregroundColor(Color(.brown))
                    Image("")
                        .resizable()
                        .frame(width: 125, height: 100)
                }
                .padding(.horizontal, 10)
                .padding(.top, 150) // Aumentamos el padding superior para subir la flecha
                Spacer()
            }
            .padding(.leading, 20) // Agregamos padding izquierdo para separar el texto de los otros elementos
            .offset(x: 0, y: -20), // Ajustamos la posición vertical de la imagen
            alignment: .topLeading
        )
        .background(Color(red: 0.96, green: 0.96, blue: 0.86))
        .edgesIgnoringSafeArea(.all)
        .sheet(isPresented: $isButtonPressed) {
            ARViewContainer() // Asegura que esta vista esté definida en tu proyecto
        }
    }
}



struct UvasView: View {
    @State private var debeNavegarAFrijolote = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(red: 0.96, green: 0.96, blue: 0.86)
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    Spacer() // Este espaciador empuja todo hacia abajo, manteniéndolo centrado

                    // Contenido central
                    HStack(alignment: .center, spacing: 20) {
                        Spacer() // Empuja el contenido hacia el centro

                        Image("UvasB")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200)

                        VStack(alignment: .center, spacing: 20) {
                            // Incrementa el espacio antes del texto y botón para empujarlos más abajo
                            Spacer(minLength: 50) // Ajusta este valor según sea necesario para mover el contenido hacia abajo

                            Text("Proximamente")
                                .font(.system(size: 70, weight: .bold))
                                .foregroundColor(.purple)


                            Spacer() // Mantiene el texto y el botón juntos, empujándolos hacia arriba
                        }

                        Spacer() // Empuja el contenido hacia el centro
                    }
                    .frame(width: geometry.size.width) // Ajusta el ancho al del contenedor padre

                    Spacer() // Este espaciador ayuda a mantener el balance vertical
                }
            }
            .overlay(
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.brown)
                        .padding()
                }, alignment: .topLeading
            )
        }
        .navigationBarHidden(true)
    }
}





















struct LevelButton: View {
    @State private var isButtonPressed = false
    let level: Level
    
    var body: some View {
        Button(action: {
            if level.imageName == "frijol2" {
                // Navegar a FrijolMessageView cuando se presiona la imagen "frijol2"
                self.isButtonPressed = true
            } else {
                // Aquí puedes agregar otras acciones para diferentes niveles si es necesario
            }
        }) {
            Image(level.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: level.width, height: level.height)
                .padding(5)
        }
        .disabled(level.isLocked)
        .fullScreenCover(isPresented: $isButtonPressed, content: {
            FrijolMessageView()
        })
    }
}

struct Level: Identifiable {
    let id: Int
    let imageName: String
    let isLocked: Bool
    let width: CGFloat // Ancho personalizado de la imagen
    let height: CGFloat // Alto personalizado de la imagen
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// Extensión para Color que permite inicializar con un código hexadecimal
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(.sRGB, red: Double(r) / 255, green: Double(g) / 255, blue:  Double(b) / 255, opacity: Double(a) / 255)
    }
}

