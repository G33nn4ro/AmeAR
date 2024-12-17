//
//  VirtualView.swift
//  leARn
//
//  Created by Gennaro Liguori on 17/12/24.
//

import SwiftUI
import RealityKit

struct VirtualView: View {
    @State private var modelEntity: ModelEntity? // Riferimento al modello
    @State private var isAnimationPlaying: Bool = false // Stato per l'animazione
    @State private var rotationAngle: Float = 0.0 // Stato per la rotazione del modello
    
    var body: some View {
        VStack {
            RealityView { content in
                content.camera = .virtual
                
                // Caricamento del modello 3D
                if let loadedModel = try? await ModelEntity(named: "handModel") {
                    modelEntity = loadedModel // Salva il riferimento al modello
                    
                    // Aumenta le dimensioni del modello (scala)
                    loadedModel.transform.scale = SIMD3<Float>(0.04, 0.04, 0.04)
                    loadedModel.transform.translation = SIMD3<Float>(0.0, -0.6, 0.0) // Sposta verso il basso
                    
                    // Imposta la rotazione iniziale
                    loadedModel.transform.rotation = simd_quatf(angle: rotationAngle, axis: SIMD3<Float>(0, 1, 0))
                    
                    // Aggiungi il modello alla scena
                    content.add(loadedModel)
                    
                    // Prepara l'animazione ma NON la avvia
                    prepareModelAnimations(for: loadedModel)
                }
            }
            .frame(maxHeight: .infinity)
            .gesture(
                DragGesture()
                    .onEnded { value in
                        handleSwipe(value: value)
                    }
            )
            
            // Pulsante per avviare l'animazione
            Button(action: {
                toggleAnimation()
            }) {
                Text(isAnimationPlaying ? "Ferma Animazione" : "Avvia Animazione")
                    .frame(width: 200, height: 44)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
        }
    }
    
    /// Funzione per preparare l'animazione senza avviarla
    private func prepareModelAnimations(for modelEntity: ModelEntity) {
        for anim in modelEntity.availableAnimations {
            modelEntity.playAnimation(anim.repeat(duration: .infinity),
                                      transitionDuration: 0,
                                      startsPaused: true) // Non avvia subito l'animazione
        }
    }
    
    /// Funzione per avviare o fermare l'animazione
    private func toggleAnimation() {
        guard let entity = modelEntity else { return }
        
        if isAnimationPlaying {
            entity.stopAllAnimations() // Ferma l'animazione
        } else {
            for anim in entity.availableAnimations {
                entity.playAnimation(anim.repeat(duration: .infinity),
                                     transitionDuration: 0,
                                     startsPaused: false) // Avvia l'animazione
            }
        }
        
        // Inverti lo stato
        isAnimationPlaying.toggle()
    }
    
    /// Funzione per gestire il gesto di swipe
    private func handleSwipe(value: DragGesture.Value) {
        let horizontalMovement = value.translation.width
        
        if horizontalMovement < -20 { // Swipe verso sinistra
            rotateModel(by: -40.0) // Ruota di 40° antiorario
        } else if horizontalMovement > 20 { // Swipe verso destra
            rotateModel(by: 40.0) // Ruota di 40° orario
        }
    }
    
    /// Funzione per ruotare il modello di una certa quantità di gradi
    private func rotateModel(by degrees: Float) {
        guard let entity = modelEntity else { return }
        
        // Converti i gradi in radianti e aggiorna l'angolo di rotazione
        rotationAngle += degrees * .pi / 180.0
        
        // Applica la nuova rotazione attorno all'asse Y
        entity.transform.rotation = simd_quatf(angle: rotationAngle, axis: SIMD3<Float>(0, 1, 0))
    }
}
