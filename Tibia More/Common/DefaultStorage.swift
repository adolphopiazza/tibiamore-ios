//
//  DefaultStorage.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 25/12/23.
//

import Foundation

final class DefaultStorage {
    
    enum Keys: String {
        case character = "SavedCharactersList"
    }
    
    static let shared = DefaultStorage()
    
    private let userDefaults = UserDefaults.standard
    
    init () {}
    
    func retrieveArray(key: DefaultStorage.Keys) -> [String]? {
        return userDefaults.array(forKey: key.rawValue) as? [String]
    }
    
    func save(key: DefaultStorage.Keys, value: Any) {
        userDefaults.set(value, forKey: key.rawValue)
    }
    
}
