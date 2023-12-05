//
//  TabBarItem.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 04/12/23.
//

import SwiftUI

enum TabBarItem {
    case news
    case characters
    case worlds
    
    var title: String {
        switch self {
        case .news:
            return "News"
        case .characters:
            return "Characters"
        case .worlds:
            return "Worlds"
        }
    }
    
    var sfImage: String {
        switch self {
        case .news:
            return "newspaper"
        case .characters:
            return "person.3"
        case .worlds:
            return "globe"
        }
    }
    
    var view: some View {
        Group {
            switch self {
            case .news:
                NewsListView()
            case .characters:
                CharactersListView()
            case .worlds:
                WorldsListView()
            }
        }
    }
}
