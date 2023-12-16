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
    
    func fetch() async throws -> [NewsInformationModel] {
        let service = NetworkService<NewsModel>()
        
        do {
            let result = try await service.fetch(url: .Endpoints.News.latest)
            guard let news = result.news else {
                throw APIErrors.errorOnAPI
            }
            
            return news
        } catch {
            print("Some error occured on news service: \(error)")
            throw error
        }
    }
    
    func fetchDetails(with id: Int) async throws -> NewsDetailInformationModel {
        let service = NetworkService<NewsDetailModel>()
        
        do {
            let result = try await service.fetch(url: .Endpoints.News.details + String(id))
            guard let news = result.news, !news.title.isEmpty else {
                throw APIErrors.errorOnAPI
            }
            
            return news
        } catch {
            print("Some error occured on news service: \(error)")
            throw error
        }
    }
    
}
