//
//  NewsModel.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 04/12/23.
//

import Foundation

struct NewsModel: Decodable {
    let news: [NewsInformationModel]
}

struct NewsInformationModel: Decodable {
    let category: String
    let date: String
    let id: Int
    let news: String
    let type: String
    let url: String
    let url_api: String
}
