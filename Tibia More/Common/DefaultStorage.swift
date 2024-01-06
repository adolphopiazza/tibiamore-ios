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
    
    func clear(key: DefaultStorage.Keys) {
        userDefaults.removeObject(forKey: key.rawValue)
    }
    
    func removeString(value: String, from key: DefaultStorage.Keys) -> Bool {
        guard var arr = retrieveArray(key: key), arr.contains(value) else { return false }
        
        arr.remove(at: arr.firstIndex(of: value)!) // Should not crash since we are checking if arr has the value 🥱
        save(key: key, value: arr)
        
        return true
    }
    
}
