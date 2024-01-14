//
//  RashidViewModel.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 14/01/24.
//

import Foundation

@Observable
final class RashidViewModel {
    
    let viewTitle: String = "Rashid"
    var isLoading: Bool = false
    var isShowingInfo: Bool = false
    var hasError: Bool = false
    var rashidCity: String = ""
    
    var opacity: Double {
        if isLoading {
            return 0
        }
        
        if hasError && !isLoading {
            return 0
        }
        
        return 1
    }
    
    @MainActor func fetch() async {
        defer {
            self.isLoading = false
        }
        
        self.isLoading = true
        
        do {
            let city = try await UtilsService.shared.fetchRashid()
            self.rashidCity = city
            self.hasError = false
        } catch {
            print("Some error on RashidViewModel: \(error)")
            self.hasError = true
        }
    }
    
}
