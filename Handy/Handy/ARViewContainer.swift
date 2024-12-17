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
    @Binding var allPointsDetected: Bool

    func makeUIView(context: Context) -> ARView {
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = []
        config.environmentTexturing = .automatic
        arView.session.run(config)

        let anchor = AnchorEntity(world: handPosition)
        arView.scene.addAnchor(anchor)
        context.coordinator.anchorEntity = anchor

        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {
        if allPointsDetected {
            if context.coordinator.modelEntity == nil {
                do {
                    let modelEntity = try Entity.loadModel(named: modelName)
                    modelEntity.scale = SIMD3<Float>(0.02, 0.02, 0.02)
                    context.coordinator.modelEntity = modelEntity
                    context.coordinator.anchorEntity?.addChild(modelEntity)

                    // Aggiungi animazioni
                    startModelAnimations(for: modelEntity)
                } catch {
                    print("Error loading model: \(error.localizedDescription)")
                }
            }

            // Sposta l'aereo di 30 centimetri in avanti
            let offset: SIMD3<Float> = SIMD3(-1.0, 0, -0.3)
            context.coordinator.anchorEntity?.position = handPosition + offset

        } else {
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

    private func startModelAnimations(for modelEntity: Entity) {
        if let modelEntity = modelEntity as? ModelEntity {
            for anim in modelEntity.availableAnimations {
                modelEntity.playAnimation(anim.repeat(duration: .infinity),
                                          transitionDuration: 1.25,
                                          startsPaused: false)
            }
        }
    }
}
