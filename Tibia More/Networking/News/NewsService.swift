//
//  NewsService.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 04/12/23.
//

import Foundation

final class NewsService {
    
    static let shared = NewsService()
    
    init() {}
    
    // TODO: Work on proper error handling
    func fetch() async throws -> [NewsInformationModel] {
        let fetchURL: URL = .Endpoints.News.latest
        
        do {
            let (data, _) = try await URLSession.shared.data(from: fetchURL)
            let decoded = try JSONDecoder().decode(NewsModel.self, from: data)
            return decoded.news
        } catch {
            print("Some error occured: \(error)")
            throw error
        }
    }
    
}
