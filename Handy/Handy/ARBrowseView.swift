//
//  ARBrowseView.swift
//  leARn
//
//  Created by Gennaro Liguori on 17/12/24.
//

import SwiftUI

struct ARBrowseView: View {
    var body: some View {
        
            
        NavigationView {
            
            ScrollView {
                
                VStack(spacing: 20) {
                    
                    
                    
                    // Pulsante rappresentato da un'immagine con un rettangolo arrotondato e testo
//                    NavigationLink(destination: ContentView()) {
//                        ZStack {
//                            RoundedRectangle(cornerRadius: 15)
//                                .fill(Color.blue)
//                                .frame(width: 370, height: 250)
//                                .shadow(radius: 5)
//                                .overlay(Image("AirPlaneAR")
//                                    .resizable()
//                                    .scaledToFill()
//                                    .foregroundColor(.white))
//                                .clipShape(RoundedRectangle(cornerRadius: 15))
//                            
//                            VStack {
//                                
//                                VStack {
//                                    Spacer()
//                                    RoundedRectangle(cornerRadius: 15)
//                                        .fill(
//                                            LinearGradient(
//                                                gradient: Gradient(colors: [Color.black.opacity(0.8), Color.clear]),
//                                                startPoint: .bottom,
//                                                endPoint: .top
//                                            )
//                                        )
//                                        .frame(height: 70)
//                                        .overlay(
//                                            
//                                            HStack {
//                                                Text("Scopri funzione 1")
//                                                    .font(.title2)
//                                                    .fontWeight(.bold)
//                                                    .foregroundColor(.white)
//                                                    .padding(.horizontal)
//                                                
//                                                Spacer()
//                                            }
//                                            
//                                        )
//                                }
//                                .clipShape(RoundedRectangle(cornerRadius: 15))
//                                .accessibilityLabel(Text("Press the button to execute an action"))
//
//                            }
//                        }
//                    }
                    
                    // Pulsante rappresentato da un'immagine con un rettangolo arrotondato e testo
                    NavigationLink(destination: ARTableView()) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.blue)
                                .frame(width: 370, height: 250)
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
                                        .overlay(
                                            
                                            HStack {
                                                Text("Hand Tracking and AR Integration")
                                                    .font(.title2)
                                                    .fontWeight(.bold)
                                                    .foregroundColor(.white)
                                                    .multilineTextAlignment(.leading)
                                                    .padding(.horizontal)
                                                
                                                Spacer()
                                            }
                                            
                                        )
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .accessibilityLabel(Text("Press the button to execute an action"))

                            }
                        }
                    }
                    

                    
            
                }
                .padding()
                
                
                
                Spacer()
            }
            .navigationTitle("Explore AR")
            
            
        }
            
            
        }
    }


#Preview {
    ARBrowseView()
}
