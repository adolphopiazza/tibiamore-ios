//
//  CharactersModel.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 16/12/23.
//

import Foundation

struct CharactersModel: Decodable {
    let character: CharacterModel?
}

struct CharacterModel: Decodable, Hashable, Equatable {
    let character: CharacterInfoModel
    let accountInformation: AccountInformationModel?
    let achievements: [AchievementsModel]?
    let otherCharacters: [OtherCharactersModel]?
}

// MARK: - Characters Info
struct CharacterInfoModel: Decodable, Hashable, Equatable {
    let accountStatus: String?
    let achievementPoints: Int?
    let comment: String?
    let deletionDate: String?
    let formerNames: [String]?
    let formerWorlds: [String]?
    let guild: GuildModel?
    let houses: [HouseModel]?
    let lastLogin: String?
    let level: Int?
    let marriedTo: String?
    let name: String?
    let position: String?
    let residence: String?
    let sex: String?
    let title: String?
    let traded: Bool?
    let unlockedTitles: Int?
    let vocation: String?
    let world: String?
}

struct GuildModel: Decodable, Hashable, Equatable {
    let name: String?
    let rank: String?
}

struct HouseModel: Decodable, Hashable, Equatable {
    let houseid: Int?
    let name: String?
    let paid: String?
    let town: String?
}

// MARK: - Account Information Info
struct AccountInformationModel: Decodable, Hashable, Equatable {
    let created: String?
    let loyaltyTitle: String?
    let position: String?
}

// MARK: - Achievements Info
struct AchievementsModel: Decodable, Hashable, Equatable {
    let grade: Int?
    let name: String?
    let secret: Bool?
}

// MARK: - Other Characters Info
struct OtherCharactersModel: Decodable, Hashable, Equatable {
    let deleted: Bool?
    let main: Bool?
    let name: String?
    let position: String?
    let status: String?
    let traded: Bool?
    let world: String?
}
