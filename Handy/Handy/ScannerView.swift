//
//  ScannerView.swift
//  Handy
//
//  Created by Gennaro Liguori on 10/12/24.
//

import SwiftUI
import AVFoundation
import Vision

struct ScannerView: UIViewControllerRepresentable {
    @Binding var handPoseInfo: String
    @Binding var handPoints: [CGPoint]
    @Binding var allPointsDetected: Bool
    @Binding var handPosition3D: SIMD3<Float> // Coordinate 3D calcolate

    let captureSession = AVCaptureSession()

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video),
              let videoInput = try? AVCaptureDeviceInput(device: videoCaptureDevice),
              captureSession.canAddInput(videoInput) else {
            return viewController
        }
        
        captureSession.addInput(videoInput)
        
        let videoOutput = AVCaptureVideoDataOutput()
        if captureSession.canAddOutput(videoOutput) {
            videoOutput.setSampleBufferDelegate(context.coordinator, queue: DispatchQueue(label: "videoQueue"))
            captureSession.addOutput(videoOutput)
        }
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = viewController.view.bounds
        previewLayer.videoGravity = .resizeAspectFill
        viewController.view.layer.addSublayer(previewLayer)
        
        Task {
            captureSession.startRunning()
        }
        
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
        var parent: ScannerView

        init(_ parent: ScannerView) {
            self.parent = parent
        }

        func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
            guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
            self.detectHandPose(in: pixelBuffer)
        }

        func detectHandPose(in pixelBuffer: CVPixelBuffer) {
            let request = VNDetectHumanHandPoseRequest { (request, error) in
                guard let observations = request.results as? [VNHumanHandPoseObservation], !observations.isEmpty else {
                    DispatchQueue.main.async {
                        self.parent.handPoseInfo = "No hand detected"
                        self.parent.handPoints = []
                        self.parent.allPointsDetected = false
                        self.parent.handPosition3D = SIMD3(0, 0, 0)
                    }
                    return
                }
                
                if let observation = observations.first {
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
                        self.parent.allPointsDetected = points.count == handJoints.count

                        if let hand3D = self.estimateHand3DPosition(from: self.parent.handPoints) {
                            self.parent.handPosition3D = hand3D
                        }
                    }
                }
            }

            request.maximumHandCount = 1

            let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: .up, options: [:])
            do {
                try handler.perform([request])
            } catch {
                print("Hand pose detection failed: \(error)")
            }
        }

        func convertVisionPoint(_ point: CGPoint) -> CGPoint {
            let screenSize = UIScreen.main.bounds.size
            let y = point.x * screenSize.height
            let x = point.y * screenSize.width
            return CGPoint(x: x, y: y)
        }

        func estimateHand3DPosition(from handPoints: [CGPoint]) -> SIMD3<Float>? {
            guard let wrist = handPoints.first else { return nil }
            let x = Float(wrist.x / UIScreen.main.bounds.width) * 2 - 1
            let y = Float(wrist.y / UIScreen.main.bounds.height) * 2 - 1
            let z = Float(-0.5) // Profondità fissa (può essere migliorata)
            return SIMD3(x, y, z)
        }
    }
}
