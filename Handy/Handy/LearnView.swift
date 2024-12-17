//
//  LearnView.swift
//  leARn
//
//  Created by Gennaro Liguori on 16/12/24.
//

import SwiftUI

struct LearnView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    
                    NavigationLink(destination: FoundamentalView()) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.blue)
                                .frame(width: 370, height: 100)
                                .shadow(radius: 5)
                            
                            HStack {
                                Text("Discover fundamental concepts of Augmented Reality")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.leading)
                                    .padding(.horizontal)
                                
                                Spacer()
                            }
                        }
                    }
                    
                    // Pulsante rappresentato da un'immagine con un rettangolo arrotondato e testo
                    NavigationLink(destination: VirtualView()) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.blue)
                                .frame(width: 370, height: 400)
                                .shadow(radius: 5)
                                .overlay(
                                    Image("VirtualView")
                                        .resizable()
                                        .scaledToFill()
                                        .foregroundColor(.white)
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                            
                            VStack {
                                Spacer()
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(
                                        LinearGradient(
                                            gradient: Gradient(colors: [Color.black.opacity(0.8), Color.clear]),
                                            startPoint: .bottom,
                                            endPoint: .top
                                        )
                                    )
                                    .frame(height: 70)
                                    .overlay(
                                        HStack {
                                            Text("Discover how to use gesture in AR")
                                                .font(.title2)
                                                .fontWeight(.bold)
                                                .foregroundColor(.white)
                                                .multilineTextAlignment(.center)
                                        }
                                    )
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        }
                    }
                    
                   

                    
                    // Pulsante che apre una pagina web
                    Link(destination: URL(string: "https://www.createwithswift.com/tag/realitykit/")!) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.blue)
                                .frame(width: 370, height: 100)
                                .shadow(radius: 5)
                            
                            HStack {
                                Text("Discover RealityKit")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.horizontal)
                                
                                Spacer()
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("leARn") // Spostato qui
        }
    }
}

#Preview {
    LearnView()
}
