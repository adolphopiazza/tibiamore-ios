//
//  UtilsService.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 14/01/24.
//

import Foundation

final class UtilsService {
    
    static let shared: UtilsService = UtilsService()
    
    init() {}
    
    func fetchRashid() async throws -> String {
        let service = NetworkService<String>()
        
        do {
            let result = try await service.fetch(baseURL: .tibiaLabsURL, url: .Endpoints.Utils.rashid)
            
            if result.isEmpty {
                throw APIErrors.errorOnAPI
            }
            
            return result
        } catch {
            print("Some error on Utils service, fetchRashid: \(error)")
            throw error
        }
    }
    
    func fetchCreatures() async throws -> CreaturesInfoModel {
        let service = NetworkService<CreaturesModel>()
        
        do {
            let result = try await service.fetch(url: .Endpoints.Utils.creatures)
            return result.creatures
        } catch {
            print("Some error on Utils service, fetchCreatures: \(error)")
            throw error
        }
    }
    
    func fetchCreature(race: String) async throws -> SpecificCreatureInfoModel {
        let service = NetworkService<SpecificCreatureModel>()
        
        do {
            let result = try await service.fetch(url: .Endpoints.Utils.creature + race)
            return result.creature
        } catch {
            print("Some error on Utils service, fetchCreatures: \(error)")
            throw error
        }
    }
    
    func fetchBoostableBosses() async throws -> BoostableBossesInfoModel {
        let service = NetworkService<BoostableBossesModel>()
        
        do {
            let result = try await service.fetch(url: .Endpoints.Utils.boostable)
            return result.boostableBosses
        } catch {
            print("Some error on Utils service, fetchBoostableBosses: \(error)")
            throw error
        }
    }
    
}
