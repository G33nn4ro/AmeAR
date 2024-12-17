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
                                .fill(Color(.blue))            .frame(width: 370, height: 100)
                                .shadow(radius: 5)
                            
                            HStack {
                                Text("Discover foundamental concepts of Augmented Reality")
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
                    NavigationLink(destination: ContentView()) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.blue)
                                .frame(width: 370, height: 450)
                                .shadow(radius: 5)
                                .overlay(Image("AirPlaneAR")
                                    .resizable()
                                    .scaledToFill()
                                    .foregroundColor(.white))
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                            
                            VStack {
                                
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
                                        
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .accessibilityLabel(Text("Press the button to execute an action"))

                            }
                        }
                    }
                    
                    

                    
                    // Pulsante che apre una pagina web
                    Link(destination: URL(string: "https://www.createwithswift.com/tag/realitykit/")!) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color(.blue))            .frame(width: 370, height: 100)
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
                
                
                
                Spacer()
            }
            .navigationTitle("leARn")
            
            
        }
        
    }
}



#Preview {
    LearnView()
}
