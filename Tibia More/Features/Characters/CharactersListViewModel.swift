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
    var characters: [CharacterInfoModel] = []
    
    func checkUserDefaults() {
        let userDefaults = UserDefaults.standard
        let characters = userDefaults.stringArray(forKey: "SavedCharactersList") ?? []
        
        if !characters.isEmpty {
            // retrive via network calls
            Task {
                for character in characters {
                    await fetch(name: character)
                }
            }
        }
    }
    
    func fetch(name: String) async {
        do {
            let model = try await CharactersService.shared.fetch(name: name)
            characters.append(model.character)
        } catch {
            print("Some error: \(error)")
        }
    }
    
}
