//
//  UtilsListViewModel.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 13/01/24.
//

import Foundation

@Observable
final class UtilsListViewModel {
    
    enum Utils: CaseIterable {
        case rashid
        case creatures
        case boostedBoss
        case boostedCreature
        case highscores
        case killStatistics
        case fansites
        case guilds
        
        var title: String {
            switch self {
            case .rashid:
                return "Rashid"
            case .creatures:
                return "Creatures"
            case .boostedBoss:
                return "Boosted Boss"
            case .boostedCreature:
                return "Boosted Creature"
            case .highscores:
                return "Highscores"
            case .killStatistics:
                return "Kill Statistics"
            case .fansites:
                return "Fansites"
            case .guilds:
                return "Guilds"
            }
        }
        
        var description: String {
            switch self {
            case .rashid:
                return "See where Rashid is today to make some money"
            case .creatures:
                return "Check out all the creatures of the Tibian world"
            case .boostedBoss:
                return "Today's boosted boss!"
            case .boostedCreature:
                return "Today's boosted creature!"
            case .highscores:
                return "See who's on the top"
            case .killStatistics:
                return "Kill statistics of every world"
            case .fansites:
                return "Discover some new Tibia Fansites"
            case .guilds:
                return "List of all the Tibian guilds"
            }
        }
    }
    
    let menuItems = UtilsListViewModel.Utils.allCases
    let viewTitle: String = "Utils"
    
}
