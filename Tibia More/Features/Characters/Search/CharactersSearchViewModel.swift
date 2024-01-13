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
    
    @MainActor func fetch() async {
        self.isLoading = true
        
        do {
            let result = try await CharactersService.shared.fetch(name: characterName)
            self.model = result
            self.isLoading = false
        } catch {
            print("Some error occured on characters search view model: \(error)")
            self.hasError = true
            self.isLoading = false
        }
    }
    
    func playersOnlineFrom(world name: String) async -> [OnlinePlayersModel] {
        do {
            let model = try await WorldsService.shared.fetch(world: name)
            return model.onlinePlayers
        } catch {
            print("Some world error: \(error)")
            return []
        }
    }
}
