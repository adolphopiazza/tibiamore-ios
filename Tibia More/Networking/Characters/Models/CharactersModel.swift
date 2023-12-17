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

struct CharacterModel: Decodable {
    let character: CharacterInfoModel
}

struct CharacterInfoModel: Decodable {
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

struct GuildModel: Decodable {
    let name: String?
    let rank: String?
}

struct HouseModel: Decodable {
    let houseid: Int?
    let name: String?
    let paid: String?
    let town: String?
}
