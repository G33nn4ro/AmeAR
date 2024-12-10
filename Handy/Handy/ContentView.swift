//
//  ContentView.swift
//  Handy
//
//  Created by Gennaro Liguori on 10/12/24.
//

import SwiftUI
import RealityKit

struct ContentView: View {
    @State private var handPoseInfo: String = "Detecting hand poses..."
    @State private var handPoints: [CGPoint] = []
    @State private var allPointsDetected: Bool = false
    @State private var handPosition3D: SIMD3<Float> = SIMD3(0, 0, 0)
    
    let arView = ARView(frame: .zero) // ARView condivisa

    var body: some View {
        ZStack {
            ScannerView(
                handPoseInfo: $handPoseInfo,
                handPoints: $handPoints,
                allPointsDetected: $allPointsDetected,
                handPosition3D: $handPosition3D,
                arView: arView
            )
            
            ARViewContainer(
                arView: arView,
                modelName: "handModel",
                handPosition: $handPosition3D
            )
            .edgesIgnoringSafeArea(.all)
        }
    }
}
