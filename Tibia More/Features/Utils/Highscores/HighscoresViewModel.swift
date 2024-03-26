//
//  HighscoresViewModel.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 20/01/24.
//

import Foundation

@Observable
final class HighscoresViewModel {
    
    let viewTitle: String = "Highscores"
    var isLoading: Bool = false
    var hasError: Bool = false
    
    var worlds: [String] = ["All"]
    var selectedWorld: String = "All"
    
    var categories: [HighscoresCategories] = HighscoresCategories.allCases
    var selectedCategory: HighscoresCategories = .experience
    
    var vocations: [HighscoresVocations] = HighscoresVocations.allCases
    var selectedVocation: HighscoresVocations = .all
    
    var highscores: [HighscoresPlayersModel] = []
    
    var characterModel: CharacterModel?
    var isLoadingCharacter: Bool = false
    
    var opacity: Double {
        if isLoading {
            return 0
        }
        
        if isLoadingCharacter {
            return 0.5
        }
        
        if hasError && !isLoading {
            return 0
        }
        
        return 1
    }
    
    init() {
        Task {
            await self.fetchWorlds()
            await self.fetchHighscores()
        }
    }
    
    @MainActor func fetchWorlds() async {
        defer {
            self.isLoading = false
        }
        
        self.isLoading = true
        
        do {
            let result = try await WorldsService.shared.fetch()
            
            for world in result.regularWorlds {
                self.worlds.append(world.name)
            }
            
            self.hasError = false
        } catch {
            print("Some error on fetching worlds on HighscoresViewModel: \(error)")
            self.hasError = true
        }
    }
    
    @MainActor func fetchHighscores() async {
        defer {
            self.isLoading = false
        }
        
        self.isLoading = true
        self.highscores.removeAll()
        
        do {
            let result = try await UtilsService.shared.fetchHighscores(world: self.selectedWorld,
                                                                       category: self.selectedCategory,
                                                                       vocation: self.selectedVocation)
            self.highscores = result.highscoreList
            self.hasError = false
        } catch {
            print("Some error fetching highscores on HighscoresViewModel: \(error)")
            self.hasError = true
        }
    }
    
    @MainActor func fetchCharacter(name: String) async {
        defer {
            self.isLoadingCharacter = false
        }
        
        self.isLoadingCharacter = true
        self.characterModel = nil
        
        do {
            let result = try await CharactersService.shared.fetchWithStatus(name: name)
            self.characterModel = result
        } catch {
            print("Some error fetching character on HighscoresViewModel: \(error)")
            self.hasError = true
        }
    }
    
}
