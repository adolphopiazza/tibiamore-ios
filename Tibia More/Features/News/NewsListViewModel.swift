//
//  NewsListViewModel.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 09/12/23.
//

import SwiftUI

@Observable
final class NewsListViewModel {
    
    var isLoading: Bool = false
    var hasError: Bool = false
    
    var news: [NewsInformationModel] = []
    var newsTicker: [NewsInformationModel] = []
    
    init() {
        Task {
            await self.fetchNews()
        }
    }
    
    @MainActor func fetchNews() async {
        defer {
            self.isLoading = false
        }
        
        self.isLoading = true
        
        do {
            try await fetchNewsTicker()
            try await fetchLatestNews()
            self.hasError = false
        } catch {
            print("Error when loading fetchNews: \(error)")
            self.newsTicker.removeAll()
            self.news.removeAll()
            self.hasError = true
        }
    }
    
    @MainActor private func fetchNewsTicker() async throws {
        self.newsTicker.removeAll()
        
        do {
            let news = try await NewsService.shared.fetch(endpoint: .Endpoints.News.ticker)
            self.newsTicker = Array(news.prefix(5))
        } catch {
            print("View model error: \(error)")
            throw error
        }
    }
    
    @MainActor private func fetchLatestNews() async throws {
        self.news.removeAll()
        
        do {
            let news = try await NewsService.shared.fetch()
            self.news = news
        } catch {
            print("View model error: \(error)")
            throw error
        }
    }
    
}
