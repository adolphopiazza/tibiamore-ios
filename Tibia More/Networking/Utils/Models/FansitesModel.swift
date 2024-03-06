//
//  FansitesModel.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 20/01/24.
//

import Foundation

struct FansitesModel: Decodable {
    let fansites: FansitesInfoModel
}

struct FansitesInfoModel: Decodable {
    let promoted: [FansiteModel]
    let supported: [FansiteModel]
}

struct FansiteModel: Decodable, Hashable, Equatable {
    let contact: String
    let contentType: FansiteContentModel
    let fansiteItem: Bool
    let fansiteItemUrl: String
    let homepage: String
    let languages: [String]
    let logoUrl: String
    let name: String
    let socialMedia: FansiteSocialModel
    let specials: [String]
}

struct FansiteContentModel: Decodable, Hashable, Equatable {
    let statistics: Bool
    let texts: Bool
    let tools: Bool
    let wiki: Bool
}

struct FansiteSocialModel: Decodable, Hashable, Equatable {
    let discord: Bool
    let facebook: Bool
    let instagram: Bool
    let reddit: Bool
    let twitch: Bool
    let twitter: Bool
    let youtube: Bool
}
