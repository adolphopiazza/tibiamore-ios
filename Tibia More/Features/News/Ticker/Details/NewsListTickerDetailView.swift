//
//  NewsListTickerDetailView.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 09/12/23.
//

import SwiftUI

struct NewsListTickerDetailView: View {
    
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
                                       systemImage: .SFImages.xmarkIcloud,
                                       description: Text("Please pull-to-refresh to try to get this news"))
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .refreshable {
            Task {
                await viewModel.fetch()
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
            HStack {
                Text("ticker news")
                    .font(.footnote)
                    .padding(6)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .foregroundStyle(.green)
                    )
                    .padding(.top, 6)
                
                Spacer()
                
                Text(viewModel.detailedNews.date.formatDate(with: .yyyyMMdd))
                    .font(.footnote)
                    .padding(.top, 6)
            }
            
            Text(viewModel.detailedNews.content)
                .font(.title3)
                .padding(.top, 4)
            
            Button(action: {
                let route = NavigationRoutes.News.browser(with: viewModel.detailedNews.url)
                self.navigationPath.append(route)
            }, label: {
                Text("Read on Tibia.com")
                    .frame(maxWidth: .infinity)
                    .frame(height: 30)
            })
            .buttonStyle(.borderedProminent)
        }
    }
    
}

#Preview("Light Mode") {
    NewsListTickerDetailView(viewModel: .init(newsID: 7750), navigationPath: Binding.constant(NavigationPath()))
        .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    NewsListTickerDetailView(viewModel: .init(newsID: 7750), navigationPath: Binding.constant(NavigationPath()))
        .preferredColorScheme(.dark)
}
