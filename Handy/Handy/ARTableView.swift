//
//  ARTableView.swift
//  leARn
//
//  Created by Gennaro Liguori on 17/12/24.
//

import SwiftUI
import RealityKit
import ARKit

struct ARTableView: View {
        
    @State var isPresented: Bool = false

    var body: some View {
        ScrollView {
            
            
            
            // 1.
            // Header Section
                           Text("Hand Tracking and AR Integration")
                               .font(.largeTitle)
                               .fontWeight(.bold)
                               .foregroundColor(.blue)
                               .multilineTextAlignment(.leading)
                               .padding(.vertical, 10)
                           
            // 2.
            Button {
                isPresented.toggle()
                    } label: {
                        Label("View in AR", systemImage: "arkit")
                    }.buttonStyle(BorderedProminentButtonStyle())
                .padding(24)
            
                           Divider()
                               .background(Color.gray)
                               
                           SectionView(title: "1. Hand Tracking",
                                       content:"The ScannerView is your hand tracking superhero! It tracks the user's hand movements and returns the exact position where the hand is located. Once detected, it passes this information to the next component.")

                           SectionView(title: "2. Anchor Creation and Entity Spawning",
                                       content:"The ARViewContainer takes the hand’s position from the ScannerView and creates an Anchor at that location in the AR space.")

                           SectionView(title: "3. Immersive Experience",
                                       content: "With the anchor in place, an entity (like a 3D box, in this example) is spawned right above the anchor. This allows virtual objects to appear in the real world, precisely where the user's hand is tracked. Now your hand controls virtual objects in real time!")
                           
                           SectionView(title: "4. Combining AR with Hand Tracking",
                                       content: "In short, this setup combines hand tracking with augmented reality to create an engaging, interactive experience where real-world actions directly influence the virtual world. ")

       


        }
                .padding()
                
        // 3.
        .fullScreenCover(isPresented: $isPresented, content: {
           SheetView(isPresented: $isPresented)
        })
        
    }
}




struct SheetView: View {
    @Binding var isPresented : Bool
   
    
    var body: some View {
        // 1.
        ZStack(alignment: .topTrailing) {

            ContentView()
                .ignoresSafeArea(edges: .all)

            // 2.
            Button() {
                isPresented.toggle()
            } label: {
                Image(systemName: "xmark.circle")
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
            }
            .padding(24)
        }
    }
}


#Preview {
    ARTableView()
}
