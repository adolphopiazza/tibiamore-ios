//
//  TabBarItem.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 04/12/23.
//

import SwiftUI

enum TabBarItem: Int {
    case news
    case characters
    case worlds
    case utils
    
    var title: String {
        switch self {
        case .news:
            return "News"
        case .characters:
            return "Characters"
        case .worlds:
            return "Worlds"
        case .utils:
            return "Utils"
        }
    }
    
    var sfImage: String {
        switch self {
        case .news:
            return .SFImages.newspaper
        case .characters:
            return .SFImages.person3
        case .worlds:
            return .SFImages.globe
        case .utils:
            return .SFImages.keyboardBadgeEllipsis
        }
    }
    
    func view(path: Binding<NavigationPath>) -> AnyView {
        switch self {
        case .news:
            return AnyView(NewsListView(navPath: path))
        case .characters:
            return AnyView(CharactersListView(navigationPath: path))
        case .worlds:
            return AnyView(WorldsListView(navigationPath: path))
        case .utils:
            return AnyView(UtilsListView(navigationPath: path))
        }
    }
}
