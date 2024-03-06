//
//  WikiService.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 19/02/24.
//

import Foundation

final class WikiService {
    
    static let shared: WikiService = WikiService()
    
    init() {}
    
    func fetch(text: String) async throws -> [String] {
        let service = NetworkService<WikiModel>()
        
        do {
            let result = try await service.fetch(baseURL: .tibiaFandomURL, url: .Endpoints.Wiki.search + text)
            return result.query.search.map { $0.title }
        } catch {
            print("Some error occurred in fetch on WikiService: \(error)")
            throw error
        }
    }
}
