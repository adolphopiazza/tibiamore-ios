//
//  Strings+Ext.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 14/12/23.
//

import Foundation

extension String {
    
    enum DateFormats: String {
        case yyyyMMdd = "yyyy-MM-dd"
        case yyyyMMddTHHmmssZ = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    }
    
    func formatDate(with format: DateFormats) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        
        guard let date = formatter.date(from: self) else { return self }
        
        formatter.setLocalizedDateFormatFromTemplate("MMM d, yyyy")
        return formatter.string(from: date)
    }
    
}

// MARK: - SystemImages
extension String {
    
    struct SFImages {
        static let newspaper = "newspaper"
        static let person3 = "person.3"
        static let person2Slash = "person.2.slash"
        static let globe = "globe"
        static let xmarkIcloud = "xmark.icloud"
        static let infoCircle = "info.circle"
        static let magnifyingglass = "magnifyingglass"
        static let trash = "trash"
    }
    
}
