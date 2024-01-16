//
//  CreaturesModel.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 14/01/24.
//

import Foundation

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
