//
//  ARView.swift
//  eros
//
//  Created by iOS Lab on 01/02/24.
//

import SwiftUI
import ARKit
import RealityKit

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        // Asegúrate de que tu archivo .reality se llame 'Frijol' y esté añadido al proyecto
        let frijolAnchor = try! Culti.loadScene()
        
        // Agrega el ancla al ARView
        arView.scene.anchors.append(frijolAnchor)
        
        // Configuración de la sesión de AR
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical] // Detecta planos horizontales y verticales
        config.environmentTexturing = .automatic // Permite que RealityKit infiera la iluminación del entorno
        arView.session.run(config)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    typealias UIViewType = ARView
}


// Segunda animacion del vaso
struct ARViewContainer2: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        // Asegúrate de que tu archivo .reality se llame 'Frijol' y esté añadido al proyecto
        let frijolAnchor = try! Recipiente.loadScene()
        
        // Agrega el ancla al ARView
        arView.scene.anchors.append(frijolAnchor)
        
        // Configuración de la sesión de AR
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical] // Detecta planos horizontales y verticales
        config.environmentTexturing = .automatic // Permite que RealityKit infiera la iluminación del entorno
        arView.session.run(config)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    typealias UIViewType = ARView
}


// Tercera animacion del algodon

struct ARViewContainer3: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        // Asegúrate de que tu archivo .reality se llame 'Frijol' y esté añadido al proyecto
        let frijolAnchor = try! Algodon.loadScene()
        
        // Agrega el ancla al ARView
        arView.scene.anchors.append(frijolAnchor)
        
        // Configuración de la sesión de AR
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical] // Detecta planos horizontales y verticales
        config.environmentTexturing = .automatic // Permite que RealityKit infiera la iluminación del entorno
        arView.session.run(config)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    typealias UIViewType = ARView
}


// Tercera animacion del frijolo

struct ARViewContainer4: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        // Asegúrate de que tu archivo .reality se llame 'Frijol' y esté añadido al proyecto
        let frijolAnchor = try! Frijolito.loadScene()
        
        // Agrega el ancla al ARView
        arView.scene.anchors.append(frijolAnchor)
        
        // Configuración de la sesión de AR
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical] // Detecta planos horizontales y verticales
        config.environmentTexturing = .automatic // Permite que RealityKit infiera la iluminación del entorno
        arView.session.run(config)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    typealias UIViewType = ARView
}


struct ARViewContainer5: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        // Asegúrate de que tu archivo .reality se llame 'Frijol' y esté añadido al proyecto
        let frijolAnchor = try! Regar.loadScene()
        
        // Agrega el ancla al ARView
        arView.scene.anchors.append(frijolAnchor)
        
        // Configuración de la sesión de AR
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical] // Detecta planos horizontales y verticales
        config.environmentTexturing = .automatic // Permite que RealityKit infiera la iluminación del entorno
        arView.session.run(config)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    typealias UIViewType = ARView
}


struct ARViewContainer6: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        // Asegúrate de que tu archivo .reality se llame 'Frijol' y esté añadido al proyecto
        let frijolAnchor = try! Germinar.loadScene()// aqui pones el archivo de realidad virtual
        
        // Agrega el ancla al ARView
        arView.scene.anchors.append(frijolAnchor)
        
        // Configuración de la sesión de AR
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical] // Detecta planos horizontales y verticales
        config.environmentTexturing = .automatic // Permite que RealityKit infiera la iluminación del entorno
        arView.session.run(config)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    typealias UIViewType = ARView
}


struct ARViewContainer7: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        // Asegúrate de que tu archivo .reality se llame 'Frijol' y esté añadido al proyecto
        let frijolAnchor = try! Transplante.loadScene()
        
        // Agrega el ancla al ARView
        arView.scene.anchors.append(frijolAnchor)
        
        // Configuración de la sesión de AR
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical] // Detecta planos horizontales y verticales
        config.environmentTexturing = .automatic // Permite que RealityKit infiera la iluminación del entorno
        arView.session.run(config)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    typealias UIViewType = ARView
}



struct ARViewContainer8: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        // Asegúrate de que tu archivo .reality se llame 'Frijol' y esté añadido al proyecto
        let frijolAnchor = try! Final.loadScene()
        
        // Agrega el ancla al ARView
        arView.scene.anchors.append(frijolAnchor)
        
        // Configuración de la sesión de AR
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical] // Detecta planos horizontales y verticales
        config.environmentTexturing = .automatic // Permite que RealityKit infiera la iluminación del entorno
        arView.session.run(config)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    typealias UIViewType = ARView
}
