//
//  CharactersService.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 16/12/23.
//

import Foundation

final class CharactersService {
    
    static let shared = CharactersService()
    
    init() {}
    
    func fetch(name: String) async throws -> CharacterModel {
        let service = NetworkService<CharactersModel>()
        
        do {
            let result = try await service.fetch(url: .Endpoints.Characters.details + name)
            guard let character = result.character else {
                throw APIErrors.errorOnAPI
            }
            
            return character
        } catch {
            print("Some error occured on the characters service: \(error)")
            throw error
        }
    }
    
}
