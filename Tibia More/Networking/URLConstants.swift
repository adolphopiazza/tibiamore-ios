//
//  URLConstants.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 04/12/23.
//

import Foundation

/// Note: we force unwrap this because they're constants and aren't suppose to
/// change, so we'll not get any crashes.

extension URL {
    static let baseURL: URL = URL(string: "https://api.tibiadata.com")!
    
    struct Endpoints {
        struct News {
            static let latest: URL = URL(string: "\(URL.baseURL.absoluteString)/v4/news/latest")!
        }
    }
}
