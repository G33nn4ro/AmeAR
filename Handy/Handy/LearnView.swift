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
                    
                   
                    // Frame ARView al centro della schermata
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.gray.opacity(0.2)) // Sfondo leggero
                            .shadow(radius: 5)

                        VirtualView() // Integra ARPreView
                    }
                    .frame(width: 370, height: 400) // Dimensione del frame
                    .cornerRadius(12)
                    

                    
                    

                    
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
