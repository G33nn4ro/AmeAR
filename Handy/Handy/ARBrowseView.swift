//
//  ARBrowseView.swift
//  leARn
//
//  Created by Gennaro Liguori on 17/12/24.
//

import SwiftUI

struct ARBrowseView: View {
    @State private var searchText: String = "" // Stato per il testo della ricerca
    
    // Titoli delle card, immagini e viste associate
    let cards: [(title: String, imageName: String, destination: AnyView)] = [
        ("Scopri funzione 1", "AirPlaneAR", AnyView(ContentView())),
        ("Scopri funzione 2", "AirPlaneAR", AnyView(FoundamentalView())),
        
    ]
    
    // Filtraggio basato sul testo
    var filteredCards: [(title: String, imageName: String, destination: AnyView)] {
        if searchText.isEmpty {
            return cards
        } else {
            return cards.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // Barra di ricerca
                TextField("Cerca...", text: $searchText)
                    .padding(10)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(filteredCards, id: \.title) { card in
                            NavigationLink(destination: card.destination) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color.blue)
                                        .frame(width: 370, height: 250)
                                        .shadow(radius: 5)
                                        .overlay(
                                            Image(card.imageName) // Immagine dinamica
                                                .resizable()
                                                .scaledToFill()
                                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                        )
                                    
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
                                                    Text(card.title)
                                                        .font(.title2)
                                                        .fontWeight(.bold)
                                                        .foregroundColor(.white)
                                                        .padding(.horizontal)
                                                    Spacer()
                                                }
                                            )
                                    }
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .accessibilityLabel(Text("Vai a \(card.title)"))
                            }
                        }
                    }
                    .padding()
                }
                .navigationTitle("leARn")
            }
        }
    }
}



#Preview {
    ARBrowseView()
}
