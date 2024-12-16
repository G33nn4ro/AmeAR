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
                    // Pulsante rappresentato da un'immagine con un rettangolo arrotondato e testo
                    NavigationLink(destination: ContentView()) {
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
                                                                      gradient: Gradient(colors: [Color.black.opacity(0.6), Color.clear]),
                                                                      startPoint: .bottom,
                                                                      endPoint: .top
                                                                  )
                                                              )
                                                              .frame(height: 70)
                                                              .overlay(
                                                                  Text("Scopri funzione 1")
                                                                      .font(.headline)
                                                                      .foregroundColor(.white)
                                                                      .padding(.horizontal)
                                                              )
                                                      }
                                                      .clipShape(RoundedRectangle(cornerRadius: 15))
                            }
                        }
                    }
                    
                    // Pulsante che apre una pagina web
                    Link(destination: URL(string: "https://www.google.com")!) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.blue)
                                .frame(width: 370, height: 100)
                                .shadow(radius: 5)

                            VStack {
                                Text("Scopri le news")
                                    .font(.body)
                                    .foregroundColor(.white)
                                    .padding(.top, 10)
                            }
                        }
                    }
                }
                .padding()

                    
                    
                    Spacer()
                }
                .navigationTitle("leARn")
                .padding()
                
            }
           
        }
    }



#Preview {
    LearnView()
}
