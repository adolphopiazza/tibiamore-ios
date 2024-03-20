//
//  CharacterSearchDetailsViewModel.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 05/01/24.
//

import Foundation

@Observable
final class CharacterSearchDetailsViewModel {

    var model: CharacterModel
    var isFromSearch = true
    var isFromWorlds = false
    var isLoading: Bool = false
    
    init(model: CharacterModel, isFromSearch: Bool = true, isFromWorlds: Bool = false) {
        self.model = model
        self.isFromSearch = isFromSearch
        self.isFromWorlds = isFromWorlds
        
        guard let characters = DefaultStorage.shared.retrieveArray(key: .character) else {
            return
        }
        
        if characters.contains(model.character.name ?? "") {
            self.isFromSearch = false
        }
    }
    
    @MainActor func fetchCharacter(name: String) async throws -> CharacterModel {
        defer {
            self.isLoading = false
        }
        
        self.isLoading = true
        do {
            let result = try await CharactersService.shared.fetch(name: name)
            return result
        } catch {
            print("Some error occured on CharacterSearchDetailsViewModel: \(error)")
            throw error
        }
    }
    
}
