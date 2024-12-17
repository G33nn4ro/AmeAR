//
//  VirtualView.swift
//  leARn
//
//  Created by Gennaro Liguori on 17/12/24.
//

import SwiftUI
import RealityKit

struct VirtualView: View {
    var body: some View {
        VStack {
            RealityView { content in
                content.camera = .virtual
                
                // Caricamento del modello 3D
                if let modelEntity = try? await ModelEntity(named: "handModel") {
                    // Aumenta le dimensioni del modello (scala)
                    modelEntity.transform.scale = SIMD3<Float>(0.07, 0.07, 0.07) // Scala doppia
                    
                    modelEntity.transform.translation = SIMD3<Float>(0.0, -0.6, 0.0) // Sposta verso il basso

                    
                    // Aggiungi il modello alla scena
                    content.add(modelEntity)
                    
                    // Avvia le animazioni del modello
                    startModelAnimations(for: modelEntity)
                }
            }
        }
        
    }
    
    /// Funzione per avviare le animazioni di un modello
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
