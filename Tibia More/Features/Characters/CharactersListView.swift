//
//  CharactersListView.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 04/12/23.
//

import SwiftUI

struct CharactersListView: View {
    
    @State private var viewModel: CharactersListViewModel = CharactersListViewModel()
    
    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            List {
                Text("First character")
            }
            .navigationTitle(viewModel.viewTitle)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Search for character", systemImage: "magnifyingglass") {
                        viewModel.navigationPath.append(NavigationRoutes.Characters.search)
                    }
                }
            }
            .navigationDestination(for: NavigationRoutes.Characters.self) { route in
                switch route {
                case .search:
                    CharactersSearchView()
                }
            }
        }
    }
    
}

#Preview {
    CharactersListView()
}
