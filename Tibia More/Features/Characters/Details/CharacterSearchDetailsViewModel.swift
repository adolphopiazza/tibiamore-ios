//
//  CharacterSearchDetailsViewModel.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 05/01/24.
//

import Foundation

final class CharacterSearchDetailsViewModel {

    var model: CharacterModel
    var isFromSearch = true
    
    init(model: CharacterModel, isFromSearch: Bool = true) {
        self.model = model
        self.isFromSearch = isFromSearch
        
        guard let characters = DefaultStorage.shared.retrieveArray(key: .character) else {
            return
        }
        
        if characters.contains(model.character.name ?? "") {
            self.isFromSearch = false
        }
    }
    
}
