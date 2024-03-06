//
//  WorldsListViewModel.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 06/01/24.
//

import SwiftUI

@Observable
final class WorldsListViewModel {
    
    let viewTitle: String = "Worlds"
    
    var isLoading: Bool = false
    var hasError: Bool = false
    var model: WorldsInfoModel?
    
    init() {
        Task {
            await self.fetch()
        }
    }
    
    @MainActor func fetch() async {
        defer {
            self.isLoading = false
        }
        
        self.isLoading = true
        
        do {
            let result = try await WorldsService.shared.fetch()
            self.model = result
            self.hasError = false
        } catch {
            print("some error on worlds list view model: \(error)")
            self.hasError = true
        }
    }
    
}
