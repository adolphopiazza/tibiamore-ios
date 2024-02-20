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
                ZStack {
                    TextField("Search on Wiki", text: $viewModel.searchTerm)
                        .autocorrectionDisabled()
                        .keyboardType(.default)
                    
                    HStack {
                        Spacer()
                        
                        Image(systemName: .SFImages.xCircleFill)
                            .foregroundStyle(.quaternary)
                            .onTapGesture {
                                viewModel.searchTerm = ""
                            }
                            .opacity(viewModel.searchTerm.isEmpty ? 0 : 1)
                    }
                }
                
                List(viewModel.searchResults, id: \.self) { text in
                    if viewModel.searchResults.isEmpty {
                        EmptyView() // workaround to not dismiss keyboard on first search
                    } else {
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
            .onSubmit {
                if viewModel.searchTerm.isEmpty {
                    viewModel.searchResults = []
                }
            }
            .overlay {
                if viewModel.searchResults.isEmpty {
                    ContentUnavailableView("Wiki",
                                           systemImage: .SFImages.book,
                                           description: Text("Start typing on the search bar to find something useful on the Wiki"))
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
