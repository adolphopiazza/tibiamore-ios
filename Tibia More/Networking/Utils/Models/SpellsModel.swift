//
//  SpellsModel.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 19/02/24.
//

import Foundation

struct SpellsModel: Decodable {
    let name: String
    let imageUrl: String
    let spellInformation: SpellInformationModel
    let spellId: String
}

struct SpellInformationModel: Decodable {
    let vocation: [String]
    let level: Int
    let premiumOnly: Bool
    let formula: String
}
