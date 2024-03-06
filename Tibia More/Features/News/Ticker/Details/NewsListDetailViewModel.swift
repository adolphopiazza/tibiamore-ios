//
//  NewsListDetailViewModel.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 09/12/23.
//

import SwiftUI

@Observable
final class NewsListDetailViewModel {
    
    var detailedNews: NewsDetailInformationModel
    var isLoading: Bool = false
    var hasError: Bool = false
    
    let newsID: Int
    
    init(newsID: Int) {
        self.detailedNews = NewsDetailInformationModel()
        self.newsID = newsID
        
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
            let detailedNews = try await NewsService.shared.fetchDetails(with: self.newsID)
            self.detailedNews = detailedNews
            self.hasError = false
        } catch {
            print("View model error: \(error)")
            self.hasError = true
        }
    }
    
}
