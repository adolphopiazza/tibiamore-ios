//
//  TabBarView.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 04/12/23.
//

import SwiftUI

struct TabBarView: View {
    
    @State private var selectedIndex: Int = 0
    
    @State private var newsPath: NavigationPath = NavigationPath()
    @State private var charactersPath: NavigationPath = NavigationPath()
    @State private var worldsPath: NavigationPath = NavigationPath()
    @State private var utilsPath: NavigationPath = NavigationPath()
    @State private var wikiPath: NavigationPath = NavigationPath()
    
    var selectionBinding: Binding<Int> { Binding(
        get: {
            self.selectedIndex
        },
        set: {
            if $0 == selectedIndex {
                switch $0 {
                case TabBarItem.news.rawValue:
                    newsPath.removeLast(newsPath.count)
                case TabBarItem.characters.rawValue:
                    charactersPath.removeLast(charactersPath.count)
                case TabBarItem.worlds.rawValue:
                    worldsPath.removeLast(worldsPath.count)
                case TabBarItem.utils.rawValue:
                    utilsPath.removeLast(utilsPath.count)
                case TabBarItem.wiki.rawValue:
                    wikiPath.removeLast(wikiPath.count)
                default:
                    break
                }
            }
            
            self.selectedIndex = $0
        }
    )}
    
    var body: some View {
        TabView(selection: selectionBinding) {
            TabBarItem.news.view(path: $newsPath)
                .tabItem {
                    Label(TabBarItem.news.title,
                          systemImage: TabBarItem.news.sfImage)
                }
                .tag(TabBarItem.news.rawValue)
            
            TabBarItem.characters.view(path: $charactersPath)
                .tabItem {
                    Label(TabBarItem.characters.title,
                          systemImage: TabBarItem.characters.sfImage)
                }
                .tag(TabBarItem.characters.rawValue)
            
            TabBarItem.worlds.view(path: $worldsPath)
                .tabItem {
                    Label(TabBarItem.worlds.title,
                          systemImage: TabBarItem.worlds.sfImage)
                }
                .tag(TabBarItem.worlds.rawValue)
            
            TabBarItem.utils.view(path: $utilsPath)
                .tabItem {
                    Label(TabBarItem.utils.title,
                          systemImage: TabBarItem.utils.sfImage)
                }
                .tag(TabBarItem.utils.rawValue)
            
            TabBarItem.wiki.view(path: $wikiPath)
                .tabItem {
                    Label(TabBarItem.wiki.title,
                          systemImage: TabBarItem.wiki.sfImage)
                }
                .tag(TabBarItem.wiki.rawValue)
        }
    }
    
}

#Preview {
    TabBarView()
}
