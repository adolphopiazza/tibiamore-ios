//
//  AppLanguage.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 16/06/24.
//

import Foundation

final class AppLanguage {
    
    static let shared: AppLanguage = AppLanguage()
    
    enum Languages {
        case pt
        case en
    }
    
    var wikiSearchURL: String {
        return getLanguage() == .en ? .TibiaFandom.search : .TibiaWiki.search
    }
    
    var wikiDetailURL: String {
        return getLanguage() == .en ? .TibiaFandom.detail: .TibiaWiki.detail
    }
    
    private func getLanguage() -> Languages {
        if let language = NSLocale.preferredLanguages.first {
            return language.range(of: "en") != nil ? .en : .pt
        }
        
        return .en // Fallback to default language
    }
    
}
