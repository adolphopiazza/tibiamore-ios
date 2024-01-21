//
//  GuildsViewModel.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 21/01/24.
//

import Foundation

@Observable
final class GuildsViewModel {
    
    let viewTitle: String = "Guilds"
    var isLoading: Bool = false
    var hasError: Bool = false
    
    var selectedWorld: String = "Belobra"
    var worlds: [String] = []
    
    var guilds: [ActiveGuildsModel] = []
    
    var opacity: Double {
        if isLoading {
            return 0
        }
        
        if !isLoading && worlds.isEmpty {
            return 0
        }
        
        if !isLoading && guilds.isEmpty {
            return 0
        }
        
        if !isLoading && hasError {
            return 0
        }
        
        return 1
    }
    
    init() {
        Task {
            await self.fetchWorlds()
            await self.fetchGuilds()
        }
    }
    
    @MainActor private func fetchWorlds() async {
        defer {
            self.isLoading = false
        }
        
        self.isLoading = true
        
        do {
            let result = try await WorldsService.shared.fetch()
            self.worlds = result.regularWorlds.map({ $0.name })
            self.hasError = false
        } catch {
            print("Some error on GuildsViewModel, fetchWorlds: \(error)")
            self.hasError = true
        }
    }
    
    @MainActor func fetchGuilds() async {
        defer {
            self.isLoading = false
        }
        
        self.isLoading = true
        self.guilds.removeAll()
        
        do {
            let result = try await UtilsService.shared.fetchGuilds(of: selectedWorld)
            self.guilds = result.active
            self.hasError = false
        } catch {
            print("Some error on GuildsViewModel, fetchGuilds: \(error)")
            self.hasError = true
        }
    }
    
}
