//
//  WikiModel.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 19/02/24.
//

import Foundation

struct WikiModel: Decodable {
    let query: WikiSearchModel
}

struct WikiSearchModel: Decodable {
    let search: [WikiSearchDetailModel]
}

struct WikiSearchDetailModel: Decodable {
    let title: String
}

