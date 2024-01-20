//
//  BoostedBossViewModel.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 19/01/24.
//

import Foundation

@Observable
final class BoostedBossViewModel {
    
    let viewTitle: String = "Boosted Boss"
    var isLoading: Bool = false
    var hasError: Bool = false
    var boostedBoss: BoostableBossesInfoModel?
    
    var opacity: Double {
        if isLoading {
            return 0
        }
        
        if !isLoading && boostedBoss == nil {
            return 0
        }
        
        if !isLoading && hasError {
            return 0
        }
        
        return 1
    }
    
    init() {
        Task {
            await self.fetch()
        }
    }
    
    @MainActor func fetch() async {
        defer {
            self.isLoading = false
        }
        
        self.isLoading = true
        
        do {
            let result = try await UtilsService.shared.fetchBoostableBosses()
            self.boostedBoss = result
            self.hasError = false
        } catch {
            print("Some error ocurred on BoostedBossViewModel: \(error)")
            self.hasError = true
        }
    }
    
}
