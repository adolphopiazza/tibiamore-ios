//
//  WikiViewModel.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 19/02/24.
//

import Foundation

@Observable
final class WikiViewModel {
    
    let viewTitle: String = "Wiki"
    var searchResults: [String] = []
    var searchTerm: String = ""
    
    @MainActor func fetch() async {
        do {
            let result = try await WikiService.shared.fetch(text: searchTerm)
            self.searchResults = result
        } catch {
            print("Some error occurred on fetch in WikiViewModel: \(error)")
        }
    }
    
}
