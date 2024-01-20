//
//  BoostableBossesModel.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 19/01/24.
//

import Foundation

struct BoostableBossesModel: Decodable {
    let boostableBosses: BoostableBossesInfoModel
}

struct BoostableBossesInfoModel: Decodable {
    let boosted: BoostableBossesSpecificModel
    let boostableBossList: [BoostableBossesSpecificModel]
}

struct BoostableBossesSpecificModel: Decodable {
    let name: String
    let imageUrl: String
    let featured: Bool
}
