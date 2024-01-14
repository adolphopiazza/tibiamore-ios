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
    var isLoadingCharacter: Bool = false
    var errorLoadingCharacter: Bool = false
    var characterModel: CharacterModel?
    var model: SpecificWorldInfoModel?
    let world: String
    
    var opacity: Double {
        if isLoading {
            return 0
        }
        
        if !isLoading && model == nil {
            return 0
        }
        
        if isLoadingCharacter {
            return 0.5
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
    
    @MainActor func fetchCharacter(name: String) async {
        self.isLoadingCharacter = true
        
        do {
            let result = try await CharactersService.shared.fetch(name: name)
            self.characterModel = result
            self.characterModel?.isOnline = true
            self.isLoadingCharacter = false
        } catch {
            print("Some error occured on fetch character from worlds: \(error)")
            self.errorLoadingCharacter = true
            self.isLoadingCharacter = false
        }
    }
    
}
