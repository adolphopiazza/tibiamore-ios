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
    
    func fetchWithStatus(name: String) async throws -> CharacterModel {
        do {
            var characterInfo = try await fetch(name: name)
            var onlinePlayers: [OnlinePlayersModel] = []
            
            if let charWorld = characterInfo.character.world {
                onlinePlayers = await playersOnlineFrom(world: charWorld)
            }
            
            characterInfo.isOnline = onlinePlayers.contains(where: { $0.name == name })
            return characterInfo
        } catch {
            print("Some error occured on the characters service: \(error)")
            throw error
        }
    }
    
    private func playersOnlineFrom(world name: String) async -> [OnlinePlayersModel] {
        do {
            let model = try await WorldsService.shared.fetch(world: name)
            return model.onlinePlayers
        } catch {
            print("Some world error: \(error)")
            return []
        }
    }
    
}
