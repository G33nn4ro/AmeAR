//
//  ScannerView.swift
//  Handy
//
//  Created by Gennaro Liguori on 10/12/24.
//

import SwiftUI
import AVFoundation
import Vision
import ARKit
import RealityKit

struct ScannerView: UIViewRepresentable {
    @Binding var handPoseInfo: String
    @Binding var handPoints: [CGPoint]
    @Binding var allPointsDetected: Bool
    @Binding var handPosition3D: SIMD3<Float> // Coordinate 3D calcolate

    var arView: ARView // Passa l'ARView esistente

    func makeUIView(context: Context) -> UIView {
        // Avvia il tracciamento della mano
        context.coordinator.startTracking(arView: arView)
        return UIView() // Nessun contenuto visivo, solo tracciamento
    }

    func updateUIView(_ uiView: UIView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, ARSessionDelegate {
        var parent: ScannerView
        var handPoseRequest = VNDetectHumanHandPoseRequest()
        let handTrackingQueue = DispatchQueue(label: "handTrackingQueue")

        init(_ parent: ScannerView) {
            self.parent = parent
        }

        func startTracking(arView: ARView) {
            arView.session.delegate = self
        }

        // Delegate ARSession per aggiornare il tracciamento della mano
        func session(_ session: ARSession, didUpdate frame: ARFrame) {
            handTrackingQueue.async {
                let pixelBuffer = frame.capturedImage
                let requestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: .right, options: [:])

                do {
                    try requestHandler.perform([self.handPoseRequest])
                    if let observation = self.handPoseRequest.results?.first {
                        var points: [CGPoint] = []
                        let handJoints: [VNHumanHandPoseObservation.JointName] = [
                            .wrist, .thumbTip, .indexTip, .middleTip, .ringTip, .littleTip
                        ]

                        for joint in handJoints {
                            if let recognizedPoint = try? observation.recognizedPoint(joint), recognizedPoint.confidence > 0.5 {
                                points.append(recognizedPoint.location)
                            }
                        }

                        DispatchQueue.main.async {
                            self.parent.handPoints = points.map { self.convertVisionPoint($0) }
                            self.parent.handPoseInfo = "Hand detected with \(points.count) points"
                            self.parent.allPointsDetected = points.count == 6 // Assicurati che siano rilevati tutti i punti
                            if let hand3D = self.estimateHand3DPosition(from: self.parent.handPoints) {
                                self.parent.handPosition3D = hand3D
                            }
                        }

                    }
                } catch {
                    print("Hand pose detection failed: \(error)")
                }
            }
        }

        // Converti i punti Vision nelle coordinate dello schermo
        func convertVisionPoint(_ point: CGPoint) -> CGPoint {
            let screenSize = UIScreen.main.bounds.size
            let y = point.x * screenSize.height
            let x = point.y * screenSize.width
            return CGPoint(x: x, y: y)
        }

        // Stima le coordinate 3D della mano (X, Y, Z)
        func estimateHand3DPosition(from handPoints: [CGPoint]) -> SIMD3<Float>? {
            guard let wrist = handPoints.first else { return nil }
            let x = Float(wrist.x / UIScreen.main.bounds.width) * 2 - 1
            let y = Float(wrist.y / UIScreen.main.bounds.height) * 2 - 1
            let z = Float(-0.5) // Profondità fissa (può essere migliorata)
            return SIMD3(x, y, z)
        }
    }
}
