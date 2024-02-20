//
//  SpellsViewModel.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 18/02/24.
//

import Foundation

@Observable
final class SpellsViewModel {
    
    let viewTitle: String = "Spells"
    var spells: [SpellsModel] = []
    var hasError: Bool = false
    
    var sortLevel: Bool = false
    var filteredVocation: HighscoresVocations = .all
    let vocations: [HighscoresVocations] = HighscoresVocations.allCases
    
    @MainActor func fetchSpells() async {
        do {
            let result = try await UtilsService.shared.fetchSpells()
            self.spells = result
            self.hasError = false
        } catch {
            print("Error fetching on SpellsViewModel: \(error)")
            self.hasError = true
            return
        }
    }
    
}
