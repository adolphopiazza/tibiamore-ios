//
//  NewsListRowView.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 09/12/23.
//

import SwiftUI

struct NewsListRowView: View {
    
    @State var viewModel: NewsListRowViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(viewModel.news.date.formatDate(with: .yyyyMMdd))
                
                Spacer()
                
                Text(viewModel.news.type)
            }
            .font(.footnote)
            
            Text(viewModel.news.news)
                .font(.title)
                .fontWeight(.light)
            
            HStack {
                Text(viewModel.news.category)
                    .padding(6)
                    .background {
                        RoundedRectangle(cornerRadius: 4)
                            .foregroundStyle(.green)
                    }
                
                Spacer()
                
                Text("Read on Tibia.com")
                    .padding(6)
                    .background {
                        RoundedRectangle(cornerRadius: 4)
                            .foregroundStyle(.orange)
                    }
            }
            .font(.footnote)
        }
        .fontDesign(.serif)
    }
    
}

#Preview("List style") {
    let model = NewsInformationModel(category: "development",
                                     date: "2023-12-04",
                                     id: 7639,
                                     news: "Winter Update 2023",
                                     type: "news",
                                     url: "https://www.tibia.com/news/?subtopic=newsarchive&id=7639",
                                     urlApi: "https://+https://https://api.tibiadata.com/v4/news/id/7639")
    
    return AnyView(
        NavigationStack {
            List {
                NewsListRowView(viewModel: .init(model))
            }
        }
    )
}
