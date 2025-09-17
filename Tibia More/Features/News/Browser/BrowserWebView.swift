//
//  BrowserWebView.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 16/09/25.
//

import SwiftUI
import WebKit

@available(iOS 26.0, *)
struct BrowserWebView: View {
    
    @State private var webPage = WebPage()
    @Binding var navigationPath: NavigationPath
    
    var url: String
    var newsTitle: String
    
    var body: some View {
        WebView(webPage)
            .task {
                webPage.load(URL(string: url))
            }
            .toolbar(.hidden, for: .tabBar)
            .navigationTitle(newsTitle)
            .navigationBarTitleDisplayMode(.inline)
            .clipped()
            .scrollIndicators(.hidden)
            .ignoresSafeArea(.all, edges: .bottom)
            .overlay {
                if webPage.isLoading {
                    ProgressView()
                }
            }
    }
}

#Preview {
    NavigationStack {
        if #available(iOS 26.0, *) {
            BrowserWebView(navigationPath: .constant(NavigationPath()), url: "https://www.tibia.com/news/?subtopic=newsarchive&id=8416",
                           newsTitle: "Double Exp")
        } else {
            BrowserView(navigationPath: .constant(NavigationPath()), url: "https://www.tibia.com/news/?subtopic=newsarchive&id=8416")
        }
    }
}
