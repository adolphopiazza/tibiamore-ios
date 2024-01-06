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
    
    func checkUserDefaults() {
        guard let savedCharacters = DefaultStorage.shared.retrieveArray(key: .character) else {
            return
        }
        
        self.characters.removeAll()
        
        Task {
            self.isLoading = true
            
            for character in savedCharacters {
                await fetch(name: character)
            }
            
            self.isLoading = false
        }
    }
    
    func fetch(name: String) async {
        do {
            let model = try await CharactersService.shared.fetch(name: name)
            characters.append(model)
        } catch {
            print("Some error: \(error)")
        }
    }
    
}
