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
    var isFromWorlds = false
    
    init(model: CharacterModel, isFromSearch: Bool = true, isFromWorlds: Bool = false) {
        self.model = model
        self.isFromSearch = isFromSearch
        self.isFromWorlds = isFromWorlds
        
        guard let characters = DefaultStorage.shared.retrieveArray(key: .character) else {
            return
        }
        
        if characters.contains(model.character.name ?? "") {
            self.isFromSearch = false
        }
    }
    
}
