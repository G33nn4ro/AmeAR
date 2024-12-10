//
//  ContentView.swift
//  Handy
//
//  Created by Gennaro Liguori on 10/12/24.
//

import SwiftUI
import AVFoundation
import Vision

struct ContentView: View {
    @State private var handPoseInfo: String = "Detecting hand poses..."
    @State private var handPoints: [CGPoint] = []
    @State private var allPointsDetected: Bool = false
    @State private var handPosition3D: SIMD3<Float> = SIMD3(0, 0, 0) // Coordinate 3D della mano

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                ScannerView(handPoseInfo: $handPoseInfo, handPoints: $handPoints, allPointsDetected: $allPointsDetected, handPosition3D: $handPosition3D)
                    .edgesIgnoringSafeArea(.all)

                
                ARViewContainer(modelName: "plane", handPosition: $handPosition3D)
                    .edgesIgnoringSafeArea(.all)
            }
            
            if allPointsDetected {
                Text("Full Hand Detected")
                    .padding()
                    .background(Color.green.opacity(0.8))
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.bottom, 100)
                    .transition(.scale)
            }
        }
    }
}

