//
//  NewsListView.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 04/12/23.
//

import SwiftUI

struct NewsListView: View {
    
    @State private var viewModel: NewsListViewModel = NewsListViewModel()
    
    init() {
        /// https://www.hackingwithswift.com/forums/swiftui/alert-button-color-conforming-to-accentcolor/7193/7198
        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = UIColor(Color.accent)
    }
    
    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            List(viewModel.news, id: \.id) { news in
                NewsListRowView(viewModel: .init(news))
                    .contentShape(Rectangle())
                    .onTapGesture {
                        viewModel.navigationPath.append(NavigationRoutes.News.details(of: news))
                    }
            }
            .navigationTitle(viewModel.viewTitle)
            .alert("Important information",
                   isPresented: $viewModel.showInfoAlert,
                   actions: {
                Button("OK", action: {})
            }, message: {
                Text("Some news may not be displayed correctly due to some problems when trying to extract the news from Tibia.com.\n\nBut you can use the button on the top right corner to read the same news on the Tibia website.")
            })
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Info", systemImage: "info.circle") {
                        viewModel.showInfoAlert.toggle()
                    }
                }
            }
            .refreshable {
                await viewModel.fetchLatestNews()
            }
            .overlay {
                if viewModel.news.isEmpty && !viewModel.isLoading {
                    ContentUnavailableView("No news found",
                                           systemImage: "newspaper",
                                           description: Text("Please pull-to-refresh to get the latest Tibia news"))
                }
                
                if viewModel.isLoading {
                    ProgressView()
                }
            }
            .navigationDestination(for: NavigationRoutes.News.self) { route in
                switch route {
                case .details(let news):
                    NewsListDetailView(viewModel: .init(newsID: news.id), navigationPath: $viewModel.navigationPath)
                case .browser(let url):
                    BrowserView(navigationPath: $viewModel.navigationPath, url: url)
                }
            }
        }
    }
    
}

#Preview("Light Mode") {
    NewsListView()
        .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    NewsListView()
        .preferredColorScheme(.dark)
}

#Preview("News on tab bar", body: {
    TabBarView()
})
