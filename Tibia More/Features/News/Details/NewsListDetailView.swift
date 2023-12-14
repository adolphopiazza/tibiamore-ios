//
//  NewsListDetailView.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 09/12/23.
//

import SwiftUI

struct NewsListDetailView: View {
    
    @State var viewModel: NewsListDetailViewModel
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
        ZStack {
            ScrollView {
                bodyContent
                    .fontDesign(.serif)
                    .padding([.horizontal, .bottom], 20)
                    .opacity(viewModel.isLoading || viewModel.hasError ? 0 : 1)
            }
            
            if viewModel.hasError && !viewModel.isLoading {
                ContentUnavailableView("Sorry, we are having some issues",
                                       systemImage: "xmark.icloud",
                                       description: Text("Please pull-to-refresh to try to get this news"))
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .refreshable {
            Task {
                await viewModel.fetch()
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Read it on Tibia.com") {
                    let route = NavigationRoutes.News.browser(with: viewModel.detailedNews.url)
                    self.navigationPath.append(route)
                }
            }
        }
        .overlay {
            if viewModel.isLoading {
                ProgressView()
            }
        }
    }
    
    private var bodyContent: some View {
        VStack(alignment: .leading) {
            Text(viewModel.detailedNews.title)
                .font(.largeTitle)
            
            Text(viewModel.detailedNews.date.formatDate)
                .font(.footnote)
                .padding(.top, 6)
            
            Text(viewModel.detailedNews.content)
                .font(.title3)
                .padding(.top, 2)
            
            Text(viewModel.detailedNews.category)
                .font(.footnote)
                .padding(6)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .foregroundStyle(.green)
                )
                .padding(.top, 6)
        }
    }
    
}

#Preview("Light Mode") {
    NewsListDetailView(viewModel: .init(newsID: 7639), navigationPath: Binding.constant(NavigationPath()))
        .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    NewsListDetailView(viewModel: .init(newsID: 7639), navigationPath: Binding.constant(NavigationPath()))
        .preferredColorScheme(.dark)
}
