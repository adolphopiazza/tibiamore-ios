//
//  GuildDetailsViewModel.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 21/01/24.
//

import Foundation

@Observable
final class GuildDetailsViewModel {
    
    var isLoading: Bool = false
    var hasError: Bool = false
    
    var guild: SpecificGuildInfoModel?
    
    var opacity: Double {
        if isLoading {
            return 0
        }
        
        if !isLoading && guild == nil {
            return 0
        }
        
        if !isLoading && hasError {
            return 0
        }
        
        return 1
    }
    
    init(name: String) {
        Task {
            await self.fetch(name: name)
        }
    }
    
    @MainActor private func fetch(name: String) async {
        defer {
            self.isLoading = false
        }
        
        self.isLoading = true
        
        do {
            let result = try await UtilsService.shared.fetchGuild(name: name)
            self.guild = result
            self.hasError = false
        } catch {
            print("Some error occured on GuildDetailsViewModel: \(error)")
            self.hasError = true
        }
    }
    
}
