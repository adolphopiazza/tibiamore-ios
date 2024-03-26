//
//  CharactersSearchViewModel.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 17/12/23.
//

import SwiftUI

@Observable
final class CharactersSearchViewModel {
    
    let viewTitle = "Find Character"
    
    var characterName: String = ""
    var isLoading: Bool = false
    var hasError: Bool = false
    var model: CharacterModel?
    
    @MainActor func fetchAllInfo() async {
        defer {
            self.isLoading = false
        }
        
        self.isLoading = true
        self.model = nil
        
        do {
            var character = try await fetchCharacter()
            var onlinePlayers: [OnlinePlayersModel] = []
            
            if let charWorld = character.character.world {
                onlinePlayers = await playersOnlineFrom(world: charWorld)
            }
            
            character.isOnline = onlinePlayers.contains(where: { $0.name == characterName })
            self.model = character
        } catch {
            print("Some error occured on characters search view model, fetchAllInfo: \(error)")
            self.hasError = true
        }
    }
    
    private func fetchCharacter() async throws -> CharacterModel {
        do {
            let result = try await CharactersService.shared.fetch(name: characterName)
            return result
        } catch {
            print("Some error occured on characters search view model: \(error)")
            throw error
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
