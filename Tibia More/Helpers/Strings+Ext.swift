//
//  Strings+Ext.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 14/12/23.
//

import Foundation

extension String {
    
    enum DateFormats: String {
        case yyyyMM = "yyyy-MM"
        case yyyyMMdd = "yyyy-MM-dd"
        case yyyyMMddTHHmmssZ = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    }
    
    func formatDate(with format: DateFormats) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        
        guard let date = formatter.date(from: self) else { return self }
        
        if format.rawValue.contains("dd") {
            formatter.setLocalizedDateFormatFromTemplate("MMM d, yyyy")
        } else {
            formatter.setLocalizedDateFormatFromTemplate("MMM, yyyy")
        }
        
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
        static let keyboardBadgeEllipsis = "keyboard.badge.ellipsis"
        static let chevronRight = "chevron.right"
        static let networkSlash = "network.slash"
        static let arrowClockwise = "arrow.clockwise"
        static let wand = "wand.and.rays"
        static let book = "book"
        static let xCircleFill = "x.circle.fill"
    }
    
}
