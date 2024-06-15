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
    #if DEBUG
        static let tibiaDataURL = "https://dev.tibiadata.com/v4/"
    #else
        static let tibiaDataURL = "https://api.tibiadata.com/v4/"
    #endif
    
    static let tibiaLabsURL = "https://api.tibialabs.com/v2/"
    static let tibiaFandomURL = "https://tibia.fandom.com/api.php?"
    static let tibiaWikiURL = "https://www.tibiawiki.com.br/api.php?"
    
    struct Endpoints {
        struct News {
            static let latest = "news/latest"
            static let details = "news/id/"
            static let ticker = "news/newsticker"
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
            static let creatures = "creatures"
            static let creature = "creature/"
            static let boostable = "boostablebosses"
            static let highscores = "highscores"
            static let killStatistics = "killstatistics/"
            static let fansites = "fansites"
            static let guilds = "guilds/"
            static let guild = "guild/"
        }
        
        struct Wiki {
            // I know I should be doing this by URL query parameters, but 🥱
            static let search = "action=query&list=search&format=json&srsearch="
        }
    }
}
