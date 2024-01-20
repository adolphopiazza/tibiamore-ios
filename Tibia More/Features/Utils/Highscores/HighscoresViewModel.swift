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
    
}
