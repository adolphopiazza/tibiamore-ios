//
//  CreaturesModel.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 14/01/24.
//

import Foundation

// MARK: - Creatures list model
struct CreaturesModel: Decodable {
    let creatures: CreaturesInfoModel
}

struct CreaturesInfoModel: Decodable {
    let boosted: CreaturesDetailsModel
    let creatureList: [CreaturesDetailsModel]
}

struct CreaturesDetailsModel: Decodable {
    let featured: Bool
    let imageUrl: String
    let name: String
    let race: String
}

// MARK: - Specific creature model
struct SpecificCreatureModel: Decodable {
    let creature: SpecificCreatureInfoModel
}

struct SpecificCreatureInfoModel: Decodable {
    let beConvinced: Bool
    let beParalysed: Bool
    let beSummoned: Bool
    let behaviour: String
    let convincedMana: Int
    let description: String
    let experiencePoints: Int
    let featured: Bool
    let healed: [String]?
    let hitpoints: Int
    let imageUrl: String
    let immune: [String]?
    let isLootable: Bool
    let lootList: [String]?
    let name: String
    let race: String
    let seeInvisible: Bool
    let strong: [String]?
    let summonedMana: Int
    let weakness: [String]?
}
