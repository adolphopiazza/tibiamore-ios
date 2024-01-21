//
//  FansitesViewModel.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 20/01/24.
//

import Foundation

@Observable
final class FansitesViewModel {
    
    let viewTitle: String = "Fansites"
    var isLoading: Bool = false
    var hasError: Bool = false
    var fansites: FansitesInfoModel?
    
    var opacity: Double {
        if isLoading {
            return 0
        }
        
        if !isLoading && fansites == nil {
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
    
    @MainActor private func fetch() async {
        defer {
            self.isLoading = false
        }
        
        self.isLoading = true
        
        do {
            let result = try await UtilsService.shared.fetchFansites()
            self.fansites = result
            self.hasError = false
        } catch {
            print("Some error occured on FansitesViewModel: \(error)")
            self.hasError = true
        }
    }
}
