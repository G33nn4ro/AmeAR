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
    var modelName: String
    @Binding var handPosition: SIMD3<Float>

    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = []
        config.environmentTexturing = .automatic
        
        arView.session.run(config)
        
        // Setup iniziale dell'entità
        let anchor = AnchorEntity(world: .zero)
        let modelEntity = try? Entity.loadModel(named: modelName)
        if let modelEntity = modelEntity {
            anchor.addChild(modelEntity)
        }
        arView.scene.addAnchor(anchor)
        
        context.coordinator.anchorEntity = anchor
        context.coordinator.modelEntity = modelEntity
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        context.coordinator.updateModelPosition(to: handPosition)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator {
        var anchorEntity: AnchorEntity?
        var modelEntity: Entity?

        func updateModelPosition(to position: SIMD3<Float>) {
            anchorEntity?.position = position
        }
    }
}
