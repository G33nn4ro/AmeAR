//
//  TabView.swift
//  leARn
//
//  Created by Gennaro Liguori on 17/12/24.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        NavigationStack {
            
       
        TabView {
            LearnView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Discover")
                }
            
            ARBrowseView()
                .tabItem {
                    Image(systemName: "cube.transparent")
                    Text("AR")
                }
        }
        }
    }
}

#Preview {
    MainTabView()
}

