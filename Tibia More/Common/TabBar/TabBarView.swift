//
//  TabBarView.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 04/12/23.
//

import SwiftUI

struct TabBarView: View {
    
    var body: some View {
        TabView {
            TabBarItem.news.view
                .tabItem {
                    Label(TabBarItem.news.title,
                          systemImage: TabBarItem.news.sfImage)
                }
            
            TabBarItem.characters.view
                .tabItem {
                    Label(TabBarItem.characters.title,
                          systemImage: TabBarItem.characters.sfImage)
                }
            
            TabBarItem.worlds.view
                .tabItem {
                    Label(TabBarItem.worlds.title,
                          systemImage: TabBarItem.worlds.sfImage)
                }
        }
    }
    
}

#Preview {
    TabBarView()
}
