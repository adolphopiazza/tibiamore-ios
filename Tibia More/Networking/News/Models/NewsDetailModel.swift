//
//  NewsDetailModel.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 09/12/23.
//

import Foundation

struct NewsDetailModel: Decodable {
    let news: NewsDetailInformationModel?
}

struct NewsDetailInformationModel: Decodable {
    let category: String
    let content: String
    let contentHtml: String
    let date: String
    let id: Int
    let title: String
    let type: String?
    let url: String
    
    init(category: String = "",
         content: String = "",
         contentHtml: String = "",
         date: String = "",
         id: Int = 0,
         title: String = "",
         type: String? = nil,
         url: String = "") {
        self.category = category
        self.content = content
        self.contentHtml = contentHtml
        self.date = date
        self.id = id
        self.title = title
        self.type = type
        self.url = url
    }
}
