//
//  BoostedCreatureViewModel.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 19/01/24.
//

import Foundation

@Observable
final class BoostedCreatureViewModel {
    
    let viewTitle: String = "Boosted Creature"
    var hasError: Bool = false
    var isLoading: Bool = false
    var boostedCreature: SpecificCreatureInfoModel?
    
    var opacity: Double {
        if isLoading {
            return 0
        }
        
        if !isLoading && boostedCreature == nil {
            return 0
        }
        
        if !isLoading && hasError {
            return 0
        }
        
        return 1
    }
    
    init() {
        Task {
            if let race = await self.fetch() {
                await self.fetchDetails(of: race)
            }
        }
    }
    
    @MainActor func fetch() async -> String? {
        defer {
            self.isLoading = false
        }
        
        self.isLoading = true
        
        do {
            let result = try await UtilsService.shared.fetchCreatures()
            self.hasError = false
            return result.boosted.name
        } catch {
            print("Some error on BoostedCreatureViewModel: \(error)")
            self.hasError = true
            return nil
        }
    }
    
    @MainActor func fetchDetails(of race: String) async {
        defer {
            self.isLoading = false
        }
        
        self.isLoading = true
        
        do {
            let result = try await UtilsService.shared.fetchCreature(race: race)
            self.boostedCreature = result
            self.hasError = false
        } catch {
            print("Some error on BoostedCreatureViewModel: \(error)")
            self.hasError = true
        }
    }
    
}
