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
    static let baseURL = "https://api.tibiadata.com/v4/"
    
    struct Endpoints {
        struct News {
            static let latest = "news/latest"
            static let details = "news/id/"
        }
        
        struct Characters {
            static let details = "character/"
        }
        
        struct Worlds {
            static let all = "worlds"
            static let world = "world/"
        }
    }
}
