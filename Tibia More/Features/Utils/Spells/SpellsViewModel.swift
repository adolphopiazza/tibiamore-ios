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
    
    @MainActor func fetchSpells() async {
        do {
            let result = try await UtilsService.shared.fetchSpells()
            dump(result)
        } catch {
            print("Error: \(error)")
            return
        }
    }
    
}
