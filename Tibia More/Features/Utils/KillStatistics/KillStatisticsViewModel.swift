//
//  KillStatisticsViewModel.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 20/01/24.
//

import Foundation

@Observable
final class KillStatisticsViewModel {
    
    let viewTitle: String = "Kill Statistics"
    var isLoading: Bool = false
    var hasError: Bool = false
    
    var worlds: [String] = ["Belobra"]
    var selectedWorld: String = "Belobra"
    
    var killStatistics: KillStatisticsInfoModel?
    
    var opacity: Double {
        if isLoading {
            return 0
        }
        
        if !isLoading, killStatistics == nil {
            return 0
        }
        
        if !isLoading, hasError {
            return 0
        }
        
        return 1
    }
    
    init() {
        Task {
            await self.fetchWorlds()
            await self.fetchKillStatistics()
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
            print("Some error occured on fetching worlds on KillStatisticsViewModel: \(error)")
            self.hasError = true
        }
    }
    
    @MainActor func fetchKillStatistics() async {
        defer {
            self.isLoading = false
        }
        
        self.isLoading = true
        
        do {
            let result = try await UtilsService.shared.fetchKillStatistics(world: self.selectedWorld)
            self.killStatistics = result
            self.hasError = false
        } catch {
            print("Some error occured on fetching kill statistics on KillStatisticsViewModel: \(error)")
            self.hasError = true
        }
    }
    
}
