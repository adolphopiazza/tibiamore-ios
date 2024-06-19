//
//  WorldsModel.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 06/01/24.
//

import Foundation

// MARK: - All worlds info
struct WorldsModel: Decodable {
    let worlds: WorldsInfoModel?
}

struct WorldsInfoModel: Decodable {
    let playersOnline: Int
    let recordPlayers: Int
    let recordDate: String
    let regularWorlds: [WorldModel]
}

struct WorldModel: Decodable {
    let name: String
    let status: String
    let playersOnline: Int
    let location: String
    let pvpType: String
    let premiumOnly: Bool
    let transferType: String
    let battleyeProtected: Bool
    let battleyeDate: String
    let gameWorldType: String
    let tournamentWorldType: String
}

// MARK: - Specific world info
struct SpecificWorldModel: Decodable {
    let world: SpecificWorldInfoModel?
}

struct SpecificWorldInfoModel: Decodable {
    let name: String
    let status: String
    let playersOnline: Int
    let recordPlayers: Int
    let recordDate: String
    let creationDate: String
    let location: String
    let pvpType: String
    let premiumOnly: Bool
    let transferType: String
    let worldQuestTitles: [String]?
    let battleyeProtected: Bool
    let battleyeDate: String
    let gameWorldType: String
    let tournamentWorldType: String
    let onlinePlayers: [OnlinePlayersModel]
}

struct OnlinePlayersModel: Decodable {
    let name: String
    let level: Int
    let vocation: String
}
