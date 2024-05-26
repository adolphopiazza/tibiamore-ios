//
//  CharactersListViewModel.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 17/12/23.
//

import SwiftUI

@Observable
final class CharactersListViewModel {
    
    let viewTitle = "Characters.ViewTitle"
    
    var characters: [CharacterModel] = []
    var isLoading = false
    
    func checkUserDefaults(isRefreshing: Bool = false) async {
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
        
        if isRefreshing {
            self.characters.removeAll()
            await fetch(characters: savedCharacters)
        }
    }
    
    private func fetch(characters: [String]) async {
        self.isLoading = true
        
        for character in characters {
            await fetch(name: character)
            let players = await playersOnlineFrom(world: self.characters.last?.character.world ?? "")
            
            if !players.isEmpty {
                self.characters[self.characters.count - 1].isOnline = players.contains(where: { $0.name == character })
            }
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
    
    private func playersOnlineFrom(world name: String) async -> [OnlinePlayersModel] {
        do {
            let model = try await WorldsService.shared.fetch(world: name)
            return model.onlinePlayers
        } catch {
            print("Some world error: \(error)")
            return []
        }
    }
    
}
