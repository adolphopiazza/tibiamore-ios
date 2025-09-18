//
//  NewsListView.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 04/12/23.
//

import SwiftUI

struct NewsListView: View {
    
    @State private var viewModel: NewsListViewModel = NewsListViewModel()
    @Binding var navigationPath: NavigationPath
    
    init(navPath: Binding<NavigationPath>) {
        self._navigationPath = navPath
        /// https://www.hackingwithswift.com/forums/swiftui/alert-button-color-conforming-to-accentcolor/7193/7198
        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = UIColor(Color.accent)
    }
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            Form {
                Section("News.Ticker") {
                    List(viewModel.newsTicker, id: \.id) { news in
                        NewsTickerListRowView(news: news)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                navigationPath.append(NavigationRoutes.News.details(of: news))
                            }
                    }
                }
                .opacity(viewModel.hasError ? 0 : 1)
                
                Section("News.Latest") {
                    List(viewModel.news, id: \.id) { news in
                        NewsListRowView(viewModel: .init(news))
                            .contentShape(Rectangle())
                            .onTapGesture {
                                navigationPath.append(NavigationRoutes.News.browser(with: news.url, title: news.news))
                            }
                    }
                }
                .opacity(viewModel.hasError ? 0 : 1)
            }
            .navigationTitle(viewModel.viewTitle.localized)
            .refreshable {
                await viewModel.fetchNews()
            }
            .opacity(viewModel.isLoading ? 0 : 1)
            .overlay {
                if viewModel.hasError && !viewModel.isLoading {
                    ContentUnavailableView("Networking.Error.Title",
                                           systemImage: .SFImages.networkSlash,
                                           description: Text("Networking.Error.Description"))
                }
                
                if viewModel.isLoading {
                    ProgressView()
                }
            }
            .navigationDestination(for: NavigationRoutes.News.self) { route in
                switch route {
                case .details(let news):
                    NewsListTickerDetailView(viewModel: .init(newsID: news.id), navigationPath: $navigationPath)
                case .browser(let url, let title):
                    if #available(iOS 26.0, *) {
                        BrowserWebView(navigationPath: $navigationPath, url: url, title: title)
                    } else {
                        BrowserView(navigationPath: $navigationPath, url: url)
                    }
                }
            }
        }
    }
    
}

#Preview("Light Mode") {
    NewsListView(navPath: Binding.constant(NavigationPath()))
        .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    NewsListView(navPath: Binding.constant(NavigationPath()))
        .preferredColorScheme(.dark)
}

#Preview("News on tab bar", body: {
    TabBarView()
})
