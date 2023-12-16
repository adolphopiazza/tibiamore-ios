//
//  URLConstants.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 04/12/23.
//

import Foundation

extension URL {
    static let tibiaURL = URL(string: "https://www.tibia.com")!
}

extension String {
    static let baseURL = "https://api.tibiadata.com/v4"
    
    struct Endpoints {
        struct News {
            static let latest = "\(baseURL)/news/latest"
            static let details = "\(baseURL)/news/id/"
        }
    }
}
