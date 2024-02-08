//
//  NewsTickerListRowView.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 08/02/24.
//

import SwiftUI

struct NewsTickerListRowView: View {
    
    let news: NewsInformationModel
    
    var body: some View {
        VStack {
            HStack {
                Text(news.news)
                
                Spacer()
                
                Image(systemName: .SFImages.chevronRight)
            }
            
            HStack {
                Text("ticker")
                    .padding(6)
                    .background {
                        RoundedRectangle(cornerRadius: 4)
                            .foregroundStyle(.green)
                    }
                
                Spacer()
                
                Text(news.date.formatDate(with: .yyyyMMdd))
            }
            .padding(.top, 4)
        }
        .fontDesign(.serif)
        .font(.subheadline)
    }
    
}

#Preview {
    NewsTickerListRowView(news: NewsInformationModel(category: "community",
                                                     date: "2024-02-08",
                                                     id: 7752,
                                                     news: "A new episode is available on ElPodcastibiano.com. In Episode 109, the...",
                                                     type: "ticker",
                                                     url: "https://www.tibia.com/news/?subtopic=newsarchive&id=7752",
                                                     urlApi: "https://+https://https://api.tibiadata.com/v4/news/id/7752"))
}
