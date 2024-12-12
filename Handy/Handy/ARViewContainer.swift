//
//  ARViewContainer.swift
//  Handy
//
//  Created by Gennaro Liguori on 10/12/24.
//

import SwiftUI
import RealityKit
import ARKit

struct ARViewContainer: UIViewRepresentable {
    var arView: ARView
    var modelName: String
    @Binding var handPosition: SIMD3<Float>
    @Binding var allPointsDetected: Bool // Aggiunto per verificare la rilevazione della mano

    func makeUIView(context: Context) -> ARView {
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = []
        config.environmentTexturing = .automatic
        arView.session.run(config)
        
//        // Crea un'ancora con la posizione iniziale basata su `handPosition`
//        let anchor = AnchorEntity(world: handPosition)
//        arView.scene.addAnchor(anchor)
//        context.coordinator.anchorEntity = anchor

        
        
        
//       Aggiungi un'ancora vuota
        let anchor = AnchorEntity(world: handPosition)
        arView.scene.addAnchor(anchor)
        context.coordinator.anchorEntity = anchor
        
        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {
        if allPointsDetected {
            // Se la mano è rilevata, aggiungi il modello alla posizione
            if context.coordinator.modelEntity == nil {
                do {
                    let modelEntity = try Entity.loadModel(named: modelName)
                    modelEntity.scale = SIMD3<Float>(0.04, 0.04, 0.04) // Scala del modello
                    context.coordinator.modelEntity = modelEntity
                    context.coordinator.anchorEntity?.addChild(modelEntity)
                } catch {
                    print("Error loading model: \(error.localizedDescription)")
                }
            }
            context.coordinator.anchorEntity?.position = handPosition
        } else {
            // Se la mano non è rilevata, rimuovi il modello
            if let modelEntity = context.coordinator.modelEntity {
                context.coordinator.anchorEntity?.removeChild(modelEntity)
                context.coordinator.modelEntity = nil
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator {
        var anchorEntity: AnchorEntity?
        var modelEntity: Entity?
    }
}
