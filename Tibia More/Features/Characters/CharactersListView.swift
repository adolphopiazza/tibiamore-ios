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
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            List(viewModel.characters, id: \.self) { character in
                CharactersListRowView(model: character.character, isOnline: character.isOnline ?? false)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        navigationPath.append(NavigationRoutes.Characters.details(with: character))
                    }
            }
            .disabled(viewModel.isLoading)
            .navigationTitle(viewModel.viewTitle.localized)
            .task {
                await viewModel.checkUserDefaults()
            }
            .refreshable {
                await viewModel.checkUserDefaults(isRefreshing: true)
            }
            .alert("Characters.Clear", isPresented: $clearAll, actions: {
                Button("App.Yes", role: .destructive) {
                    DefaultStorage.shared.clear(key: .character)
                    viewModel.characters.removeAll()
                }
            }, message: {
                Text("Error.Undone")
            })
            .overlay {
                if !viewModel.isLoading && viewModel.characters.isEmpty {
                    ContentUnavailableView("Characters.NoFound",
                                           systemImage: .SFImages.person2Slash,
                                           description: Text("Character.TapToSearch"))
                }
                
                if viewModel.isLoading {
                    ProgressView()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Character.Search", systemImage: .SFImages.magnifyingglass) {
                        navigationPath.append(NavigationRoutes.Characters.search)
                    }
                }
                
                if !viewModel.characters.isEmpty {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Characters.ClearAll", systemImage: .SFImages.trash) {
                            self.clearAll = true
                        }
                    }
                }
            }
            .navigationDestination(for: NavigationRoutes.Characters.self) { route in
                switch route {
                case .search:
                    CharactersSearchView(navigationPath: $navigationPath)
                case .detailsFromSearch(let model):
                    CharacterSearchDetailsView(navigationPath: $navigationPath,
                                               viewModel: CharacterSearchDetailsViewModel(model: model))
                case .details(let model):
                    CharacterSearchDetailsView(navigationPath: $navigationPath,
                                               viewModel: CharacterSearchDetailsViewModel(model: model, isFromSearch: false))
                }
            }
        }
    }
    
}

#Preview {
    CharactersListView(navigationPath: Binding.constant(NavigationPath()))
}
