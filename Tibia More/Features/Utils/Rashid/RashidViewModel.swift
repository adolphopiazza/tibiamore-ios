//
//  RashidViewModel.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 14/01/24.
//

import SwiftUI

@Observable
final class RashidViewModel {
    
    enum RashidLocation: Int, CaseIterable {
        case sunday = 1
        case monday
        case tuesday
        case wednesday
        case thursday
        case friday
        case saturday
        
        var city: String {
            switch self {
            case .sunday:
                "Carlin"
            case .monday:
                "Svargrond"
            case .tuesday:
                "Liberty Bay"
            case .wednesday:
                "Port Hope"
            case .thursday:
                "Ankrahmun"
            case .friday:
                "Darashia"
            case .saturday:
                "Edron"
            }
        }
        
        var day: LocalizedStringKey {
            switch self {
            case .sunday:
                "Sundays"
            case .monday:
                "Mondays"
            case .tuesday:
                "Tuesdays"
            case .wednesday:
                "Wednesdays"
            case .thursday:
                "Thursdays"
            case .friday:
                "Fridays"
            case .saturday:
                "Saturdays"
            }
        }
    }
    
    let viewTitle: String = "Rashid"
    var isLoading: Bool = false
    var isShowingInfo: Bool = false
    var hasError: Bool = false
    var rashidCity: String = ""
    var rashidItems: [RashidModel] = []
    
    let rashidLocations: [RashidLocation] = RashidLocation.allCases
    
    init() {
        getRashidLocation()
    }
    
    var opacity: Double {
        if isLoading {
            return 0
        }
        
        if hasError && !isLoading {
            return 0
        }
        
        return 1
    }
    
    private func getRashidLocation() {
        guard let cestTimeZone = TimeZone(identifier: "Europe/Berlin") else {
            self.hasError = true
            return
        }
        
        var calendar = Calendar.current
        calendar.timeZone = cestTimeZone
        
        let tibiaDate = Date.now.addingTimeInterval(-10 * 3600) // Go back 10 hours
        let weekday = calendar.dateComponents([.weekday], from: tibiaDate).weekday ?? 0 // Apply the Berlin timezone with the 10 hour shifted backwards
        
        rashidCity = RashidLocation(rawValue: weekday)?.city ?? "Unknown"
    }
    
}
