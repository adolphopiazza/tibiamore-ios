//
//  NewsListViewModel.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 09/12/23.
//

import Foundation

@Observable
final class NewsListViewModel {
    
    let viewTitle: String = "Latest news"
    
    var news: [NewsInformationModel] = []
    var isLoading: Bool = false
    
    init() {
        Task {
            await self.fetchLatestNews()
        }
    }
    
    @MainActor func fetchLatestNews() async {
        self.isLoading = true
        self.news.removeAll()
        
        do {
            let news = try await NewsService.shared.fetch()
            self.news = news
            self.isLoading.toggle()
        } catch {
            print("Some error: \(error)")
            self.isLoading.toggle()
        }
    }
    
}
