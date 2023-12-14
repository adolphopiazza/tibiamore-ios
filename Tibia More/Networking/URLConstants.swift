//
//  URLConstants.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 04/12/23.
//

import Foundation

/// Note: we force unwrap this because they're constants and aren't suppose to
/// change, so we'll not get any crashes.

// TODO: Maybe only store Strings here and format the URL at the service? (without the base URL of course)
extension URL {
    static let baseURL: URL = URL(string: "https://api.tibiadata.com/v4")!
    
    struct Endpoints {
        struct News {
            static let latest: URL = URL(string: "\(URL.baseURL.absoluteString)/news/latest")!
            static let details: URL = URL(string: "\(URL.baseURL.absoluteString)/news/id/")!
        }
    }
}
