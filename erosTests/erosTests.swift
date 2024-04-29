//
//  erosTests.swift
//  erosTests
//
//  Created by iOS Lab on 01/02/24.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    var body: some View {
        ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        // Asegúrate de que el nombre aquí coincida con el nombre en tu archivo Reality
        let frijolAnchor = try! Frijol.loadFrijol()
        
        // Añade el ancla de frijol a la escena
        arView.scene.anchors.append(frijolAnchor)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
