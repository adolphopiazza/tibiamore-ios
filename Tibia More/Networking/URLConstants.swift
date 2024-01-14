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
    static let tibiaDataURL = "https://api.tibiadata.com/v4/"
    static let tibiaLabsURL = "https://api.tibialabs.com/v2/"
    
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
        
        struct Utils {
            static let rashid = "rashid/city"
        }
    }
}
