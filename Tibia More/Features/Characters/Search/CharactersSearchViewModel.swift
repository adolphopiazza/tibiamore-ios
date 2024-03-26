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
            let character = try await CharactersService.shared.fetchWithStatus(name: characterName)
            self.model = character
        } catch {
            print("Some error occured on characters search view model, fetchAllInfo: \(error)")
            self.hasError = true
        }
    }
    
}
