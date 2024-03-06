//
//  NewsListRowViewModel.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 09/12/23.
//

import Foundation

@Observable
final class NewsListRowViewModel {
    
    let news: NewsInformationModel
    
    init(_ news: NewsInformationModel) {
        self.news = news
    }
}
