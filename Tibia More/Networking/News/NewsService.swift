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
            guard let news = decoded.news else {
                throw APIErrors.apiDown
            }
            
            return news
        } catch {
            print("Service error occured: \(error)")
            throw error
        }
    }
    
    func fetchDetails(with id: Int) async throws -> NewsDetailInformationModel {
        // TODO: We are force unwrapping here but think of a better solution for endpoints with user defined parameters
        let fetchURL: URL = URL(string: "\(URL.Endpoints.News.details)/\(id)")!
        
        do {
            let (data, _) = try await URLSession.shared.data(from: fetchURL)
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let decoded = try decoder.decode(NewsDetailModel.self, from: data)
            guard let news = decoded.news, !news.title.isEmpty else {
                throw APIErrors.apiDown
            }
            
            return news
        } catch {
            print("Service error: \(error)")
            throw error
        }
    }
    
}
