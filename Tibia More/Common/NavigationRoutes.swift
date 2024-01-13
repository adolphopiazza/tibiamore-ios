//
//  NavigationRoutes.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 09/12/23.
//

import Foundation

enum NavigationRoutes {
    
    enum News: Hashable {
        case details(of: NewsInformationModel)
        case browser(with: String)
    }
    
    enum Characters: Hashable {
        case search
        case detailsFromSearch(with: CharacterModel)
        case details(with: CharacterModel)
    }
    
    enum Worlds: Hashable {
        case details(of: String)
        case characterDetails(with: CharacterModel)
    }
    
}
