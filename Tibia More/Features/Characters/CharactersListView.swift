//
//  CharactersListView.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 04/12/23.
//

import SwiftUI

struct CharactersListView: View {
    
    @State private var viewModel: CharactersListViewModel = CharactersListViewModel()
    @State private var clearAll: Bool = false
    
    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            List(viewModel.characters, id: \.self) { character in
                CharactersListRowView(model: character.character)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        viewModel.navigationPath.append(NavigationRoutes.Characters.details(with: character))
                    }
            }
            .disabled(viewModel.isLoading)
            .navigationTitle(viewModel.viewTitle)
            .onAppear {
                viewModel.checkUserDefaults()
            }
            .alert("Clear all saved characters?", isPresented: $clearAll, actions: {
                Button("Yes", role: .destructive) {
                    DefaultStorage.shared.clear(key: .character)
                    viewModel.characters.removeAll()
                }
            }, message: {
                Text("This action cannot be undone")
            })
            .overlay {
                if !viewModel.isLoading && viewModel.characters.isEmpty {
                    ContentUnavailableView("No characters found",
                                           systemImage: "person.2.slash",
                                           description: Text("Tap the top right icon to search for a character"))
                }
                
                if viewModel.isLoading {
                    ProgressView()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Search for character", systemImage: .SFImages.magnifyingglass) {
                        viewModel.navigationPath.append(NavigationRoutes.Characters.search)
                    }
                }
                
                if !viewModel.characters.isEmpty {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Clear All", systemImage: .SFImages.trash) {
                            self.clearAll = true
                        }
                    }
                }
            }
            .navigationDestination(for: NavigationRoutes.Characters.self) { route in
                switch route {
                case .search:
                    CharactersSearchView(navigationPath: $viewModel.navigationPath)
                case .detailsFromSearch(let model):
                    CharacterSearchDetailsView(navigationPath: $viewModel.navigationPath,
                                               viewModel: CharacterSearchDetailsViewModel(model: model))
                case .details(let model):
                    CharacterSearchDetailsView(navigationPath: $viewModel.navigationPath,
                                               viewModel: CharacterSearchDetailsViewModel(model: model, isFromSearch: false))
                }
            }
        }
    }
    
}

#Preview {
    CharactersListView()
}
