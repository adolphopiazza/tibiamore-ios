//
//  CreaturesDetailViewModel.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 15/01/24.
//

import Foundation

@Observable
final class CreaturesDetailViewModel {
    
    var isLoading: Bool = false
    var hasError: Bool = false
    var model: SpecificCreatureInfoModel?
    let race: String
    
    init(creatureRace: String) {
        self.race = creatureRace
        
        Task {
            await fetch(race: self.race)
        }
    }
    
    @MainActor func fetch(race: String) async {
        defer {
            self.isLoading = false
        }
        
        self.isLoading = true
        
        do {
            let result = try await UtilsService.shared.fetchCreature(race: race)
            self.model = result
            self.hasError = false
        } catch {
            print("Some error occured on CreaturesDetailViewModel: \(error)")
            self.hasError = true
        }
    }
    
}
