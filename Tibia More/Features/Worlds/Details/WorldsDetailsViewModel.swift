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
    let world: String
    
    var opacity: Double {
        if isLoading {
            return 0
        }
        
        if !isLoading && model == nil {
            return 0
        }
        
        return 1
    }
    
    init(world: String) {
        self.world = world
        
        Task {
            await fetch(world)
        }
    }
    
    @MainActor func fetch(_ world: String) async {
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
