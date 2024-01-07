//
//  WorldsDetailsViewModel.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 07/01/24.
//

import SwiftUI

@Observable
final class WorldsDetailsViewModel {
    
    var isLoading: Bool = false
    var model: SpecificWorldInfoModel?
    
    init(world: String) {
        Task {
            await fetch(world)
        }
    }
    
    @MainActor private func fetch(_ world: String) async {
        self.isLoading = true
        
        do {
            let result = try await WorldsService.shared.fetch(world: world)
            self.model = result
            self.isLoading = false
        } catch {
            print("some error on worlds details view model: \(error)")
            self.isLoading = false
        }
    }
    
}
