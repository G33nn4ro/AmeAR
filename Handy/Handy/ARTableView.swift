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
        VStack {
            // 1.
            Image("toy_car")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.tint)
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 20)))
                .padding(24)

            // 2.
            Button {
                isPresented.toggle()
                    } label: {
                        Label("View in AR", systemImage: "arkit")
                    }.buttonStyle(BorderedProminentButtonStyle())
                .padding(24)


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
