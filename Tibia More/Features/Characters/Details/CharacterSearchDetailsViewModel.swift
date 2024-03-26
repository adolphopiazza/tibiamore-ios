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
    var isFromHighscores = false
    var isLoading: Bool = false
    var hasError: Bool = false
    
    var characterModel: CharacterModel?
    
    init(model: CharacterModel, isFromSearch: Bool = true, isFromWorlds: Bool = false, isFromHighscores: Bool = false) {
        self.model = model
        self.isFromSearch = isFromSearch
        self.isFromWorlds = isFromWorlds
        self.isFromHighscores = isFromHighscores
        
        guard let characters = DefaultStorage.shared.retrieveArray(key: .character) else {
            return
        }
        
        if characters.contains(model.character.name ?? "") {
            self.isFromSearch = false
        }
    }
    
    @MainActor func fetch(character: String) async {
//        defer {
//            self.isLoading = false
//        }
        
        self.isLoading = true
        self.characterModel = nil
        
        do {
            let character = try await CharactersService.shared.fetchWithStatus(name: character)
            self.characterModel = character
        } catch {
            print("Some error occured on characters search details view model, fetch: \(error)")
            self.hasError = true
        }
    }
    
}
