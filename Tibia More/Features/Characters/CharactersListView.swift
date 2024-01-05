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
            List(viewModel.characters, id: \.self) { character in
                CharacterSearchDetailsViewRow(title: character.name ?? "", value: String(character.level ?? 0))
            }
            .navigationTitle(viewModel.viewTitle)
            .onAppear {
                viewModel.checkUserDefaults()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Search for character", systemImage: .SFImages.magnifyingglass) {
                        viewModel.navigationPath.append(NavigationRoutes.Characters.search)
                    }
                }
            }
            .navigationDestination(for: NavigationRoutes.Characters.self) { route in
                switch route {
                case .search:
                    CharactersSearchView(navigationPath: $viewModel.navigationPath)
                case .details(let model):
                    CharacterSearchDetailsView(navigationPath: $viewModel.navigationPath,
                                               viewModel: CharacterSearchDetailsViewModel(model: model))
                }
            }
        }
    }
    
}

#Preview {
    CharactersListView()
}
