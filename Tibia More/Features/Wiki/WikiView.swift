//
//  WikiView.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 19/02/24.
//

import SwiftUI

struct WikiView: View {
    
    @State private var viewModel: WikiViewModel = WikiViewModel()
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            Form {
                TextField("Search on Wiki", text: $viewModel.searchTerm)
                    .autocorrectionDisabled()
                    .keyboardType(.default)
                
                List(viewModel.searchResults, id: \.self) { text in
                    LabeledContent(text) {
                        Image(systemName: .SFImages.chevronRight)
                    }
                    .contentShape(.rect)
                    .onTapGesture {
                        let url = "https://tibia.fandom.com/wiki/\(text)"
                        navigationPath.append(NavigationRoutes.Wiki.browser(with: url))
                    }
                }
            }
            .fontDesign(.serif)
            .navigationTitle(viewModel.viewTitle)
            .onChange(of: viewModel.searchTerm) { _, newValue in
                Task {
                    if !newValue.isEmpty {
                        await viewModel.fetch()
                    } else {
                        viewModel.searchResults = []
                    }
                }
            }
            .navigationDestination(for: NavigationRoutes.Wiki.self) { route in
                switch route {
                case .browser(let url):
                    BrowserView(navigationPath: $navigationPath, url: url)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        WikiView(navigationPath: Binding.constant(NavigationPath()))
    }
}
