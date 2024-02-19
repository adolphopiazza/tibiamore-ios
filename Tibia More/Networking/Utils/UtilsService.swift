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
    
    func fetchHighscores(world: String = "all", 
                         category: HighscoresCategories = .experience,
                         vocation: HighscoresVocations = .all) async throws -> HighscoresInfoModel {
        let service = NetworkService<HighscoresModel>()
        
        do {
            let result = try await service.fetch(url: "\(String.Endpoints.Utils.highscores)/\(world)/\(category.rawValue)/\(vocation.rawValue)/1")
            return result.highscores
        } catch {
            print("Some error on Utils service, fetchHighscores: \(error)")
            throw error
        }
    }
    
    func fetchKillStatistics(world: String) async throws -> KillStatisticsInfoModel {
        let service = NetworkService<KillStatisticsModel>()
        
        do {
            let result = try await service.fetch(url: .Endpoints.Utils.killStatistics + world)
            return result.killstatistics
        } catch {
            print("Some error on Utils service, fetchHighscores: \(error)")
            throw error
        }
    }
    
    func fetchFansites() async throws -> FansitesInfoModel {
        let service = NetworkService<FansitesModel>()
        
        do {
            let result = try await service.fetch(url: .Endpoints.Utils.fansites)
            return result.fansites
        } catch {
            print("Some error on Utils service, fetchHighscores: \(error)")
            throw error
        }
    }
    
    func fetchGuilds(of world: String) async throws -> GuildsInfoModel {
        let service = NetworkService<GuildsModel>()
        
        do {
            let result = try await service.fetch(url: .Endpoints.Utils.guilds + world)
            return result.guilds
        } catch {
            print("Some error on Utils service, fetchGuilds: \(error)")
            throw error
        }
    }
    
    func fetchGuild(name: String) async throws -> SpecificGuildInfoModel {
        let service = NetworkService<SpecificGuildModel>()
        
        do {
            let result = try await service.fetch(url: .Endpoints.Utils.guild + name)
            return result.guild
        } catch {
            print("Some error on Utils service, fetchGuilds: \(error)")
            throw error
        }
    }
    
    func fetchSpells() async throws -> [SpellsModel] {
        guard let url = Bundle.main.url(forResource: "spellList", withExtension: "json") else {
            print("It seems that spellList.json does not exist")
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            let spellsData = try JSONDecoder().decode([SpellsModel].self, from: data)
            
            return spellsData
        } catch {
            print("Error reading JSON: \(error)")
            throw error
        }
    }
    
}
