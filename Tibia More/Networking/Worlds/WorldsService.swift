//
//  WorldsService.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 06/01/24.
//

import Foundation

final class WorldsService {
    
    static let shared: WorldsService = WorldsService()
    
    init() {}
    
    func fetch() async throws -> WorldsInfoModel {
        let service = NetworkService<WorldsModel>()
        
        do {
            let result = try await service.fetch(url: .Endpoints.Worlds.all)
            
            guard let worldsInfo = result.worlds else {
                throw APIErrors.errorOnAPI
            }
            
            return worldsInfo
        } catch {
            print("Some error occured on the worlds service: \(error)")
            throw error
        }
    }
    
    func fetch(world: String) async throws -> SpecificWorldInfoModel {
        let service = NetworkService<SpecificWorldModel>()
        
        do {
            let result = try await service.fetch(url: .Endpoints.Worlds.world + world)
            
            guard let worldsSpecificInfo = result.world else {
                throw APIErrors.errorOnAPI
            }
            
            return worldsSpecificInfo
        } catch {
            print("Some error occured on the worlds specific service: \(error)")
            throw error
        }
    }
    
}
