//
//  HighscoresModel.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 20/01/24.
//

import Foundation

struct HighscoresModel: Decodable {
    let highscores: HighscoresInfoModel
}

struct HighscoresInfoModel: Decodable {
    let world: String
    let category: HighscoresCategories
    let vocation: HighscoresVocations
    let highscoreList: [HighscoresPlayersModel]
}

struct HighscoresPlayersModel: Decodable {
    let rank: Int
    let name: String
    let vocation: String
    let world: String
    let level: Int
    let value: Int
}

enum HighscoresVocations: String, Decodable, CaseIterable {
    case all
    case knights
    case druids
    case sorcerers
    case paladins
    
    var title: String {
        switch self {
        case .all:
            return "All"
        case .knights:
            return "Knights"
        case .druids:
            return "Druids"
        case .sorcerers:
            return "Sorcerers"
        case .paladins:
            return "Paladins"
        }
    }
}

enum HighscoresCategories: String, Decodable, CaseIterable {
    case achievements
    case axefighting
    case charmpoints
    case clubfighting
    case distancefighting
    case experience
    case fishing
    case fistfighting
    case goshnarstaint
    case loyaltypoints
    case magiclevel
    case shielding
    case swordfighting
    case dromescore
    case bosspoints
    
    var title: String {
        switch self {
        case .achievements:
            return "Achievements"
        case .axefighting:
            return "Axe Fighting"
        case .charmpoints:
            return "Charm Points"
        case .clubfighting:
            return "Club Fighting"
        case .distancefighting:
            return "Distance Fighting"
        case .experience:
            return "Experience"
        case .fishing:
            return "Fishing"
        case .fistfighting:
            return "Fist Fighting"
        case .goshnarstaint:
            return "Goshnar's Taint"
        case .loyaltypoints:
            return "Loyalty Points"
        case .magiclevel:
            return "Magic Level"
        case .shielding:
            return "Shielding"
        case .swordfighting:
            return "Swording Fighting"
        case .dromescore:
            return "Drome Score"
        case .bosspoints:
            return "Boss Points"
        }
    }
}
