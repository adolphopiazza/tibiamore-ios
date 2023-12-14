//
//  NewsListViewModel.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 09/12/23.
//

import SwiftUI

@Observable
final class NewsListViewModel {
    
    let viewTitle: String = "Latest news"
    
    var navigationPath: NavigationPath = .init()
    var news: [NewsInformationModel] = []
    var isLoading: Bool = false
    var showInfoAlert: Bool = false
    
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
