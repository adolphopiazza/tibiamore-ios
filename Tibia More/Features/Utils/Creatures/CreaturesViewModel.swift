//
//  CreaturesViewModel.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 14/01/24.
//

import Foundation

@Observable
final class CreaturesViewModel {
    
    let viewTitle: String = "Creatures"
    var isLoading: Bool = false
    var hasError: Bool = false
    var creatures: [CreaturesDetailsModel] = []
    
    init() {
        Task {
            await fetch()
        }
    }
    
    @MainActor func fetch(refreshing: Bool = false) async {
        defer {
            self.isLoading = false
        }
        
        if refreshing {
            self.creatures.removeAll()
        }
        
        self.isLoading = true
        
        do {
            let result = try await UtilsService.shared.fetchCreatures()
            self.creatures = result.creatureList
            self.hasError = false
        } catch {
            print("Some error on CreaturesViewModel: \(error)")
            self.hasError = true
        }
    }
    
}
