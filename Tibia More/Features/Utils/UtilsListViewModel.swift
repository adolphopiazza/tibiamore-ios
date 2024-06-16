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
        case fansites
        case guilds
        case spells
        case boostedBoss
        case boostedCreature
        case highscores
        case killStatistics
        
        var title: String {
            switch self {
            case .rashid:
                return "Rashid"
            case .creatures:
                return "Creatures"
            case .fansites:
                return "Fansites"
            case .guilds:
                return "Guilds"
            case .spells:
                return "Spells"
            case .boostedBoss:
                return "Boosted Boss"
            case .boostedCreature:
                return "Boosted Creature"
            case .highscores:
                return "Highscores"
            case .killStatistics:
                return "Kill Statistics"
            }
        }
        
        var description: String {
            switch self {
            case .rashid:
                return "Utils.Rashid"
            case .creatures:
                return "Utils.Creatures"
            case .fansites:
                return "Utils.Fansites"
            case .guilds:
                return "Utils.Guilds"
            case .spells:
                return "Utils.Spells"
            case .boostedBoss:
                return "Utils.BoostedBoss"
            case .boostedCreature:
                return "Utils.BoostedCreature"
            case .highscores:
                return "Utils.Highscores"
            case .killStatistics:
                return "Utils.KillStatistics"
            }
        }
    }
    
    let menuItems = UtilsListViewModel.Utils.allCases
    let viewTitle: String = "TabBar.Utils"
    
}
