//
//  CharactersListViewModel.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 17/12/23.
//

import SwiftUI

@Observable
final class CharactersListViewModel {
    
    let viewTitle = "Characters"
    
    var navigationPath: NavigationPath = NavigationPath()
    var characters: [CharacterModel] = []
    var isLoading = false
    
    func checkUserDefaults() async {
        guard let savedCharacters = DefaultStorage.shared.retrieveArray(key: .character) else {
            return
        }
        
        if self.characters.isEmpty {
            await fetch(characters: savedCharacters)
            return
        }
        
        if self.characters.count != savedCharacters.count {
            self.characters.removeAll()
            await fetch(characters: savedCharacters)
        }
    }
    
    private func fetch(characters: [String]) async {
        self.isLoading = true
        
        for character in characters {
            await fetch(name: character)
        }
        
        self.isLoading = false
    }
    
    private func fetch(name: String) async {
        do {
            let model = try await CharactersService.shared.fetch(name: name)
            characters.append(model)
        } catch {
            print("Some error: \(error)")
        }
    }
    
}
