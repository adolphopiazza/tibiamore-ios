//
//  WorldsListView.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 04/12/23.
//

import SwiftUI

struct WorldsListView: View {
    
    @State private var viewModel = WorldsListViewModel()
    @Binding var navigationPath: NavigationPath
    @State private var searchText: String = ""
    
    private var worldsFiltered: [WorldModel] {
        guard let regularWorlds = viewModel.model?.regularWorlds else {
            return []
        }
        
        if searchText.isEmpty {
            return regularWorlds
        }
        
        return regularWorlds.filter({ $0.name.lowercased().contains(searchText.lowercased()) })
    }
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            Form {
                if !worldsFiltered.isEmpty {
                    Section("About") {
                        if let playersOnline = viewModel.model?.playersOnline {
                            LabeledContent("Players.Online", value: String(playersOnline))
                        }
                        
                        if let recordPlayers = viewModel.model?.recordPlayers {
                            LabeledContent("Record.Players", value: String(recordPlayers))
                        }
                        
                        if let recordDate = viewModel.model?.recordDate.formatDate(with: .yyyyMMddTHHmmssZ) {
                            LabeledContent("Record.Date", value: recordDate)
                        }
                    }
                    .opacity(viewModel.hasError ? 0 : 1)
                }
                
                Section("TabBar.Worlds") {
                    List(worldsFiltered, id: \.name) { world in
                        WorldsListViewRow(model: world)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                navigationPath.append(NavigationRoutes.Worlds.details(of: world.name))
                            }
                    }
                }
                .opacity(viewModel.hasError ? 0 : 1)
            }
            .fontDesign(.serif)
            .navigationTitle(viewModel.viewTitle.localized)
            .refreshable {
                viewModel.model = nil
                await viewModel.fetch()
            }
            .searchable(text: $searchText)
            .navigationDestination(for: NavigationRoutes.Worlds.self, destination: { route in
                switch route {
                case .details(let world):
                    WorldsDetailsView(viewModel: WorldsDetailsViewModel(world: world), 
                                      navigationPath: $navigationPath)
                case .characterDetails(let model):
                    CharacterSearchDetailsView(navigationPath: $navigationPath,
                                               viewModel: CharacterSearchDetailsViewModel(model: model,
                                                                                          isFromWorlds: true))
                }
            })
            .opacity(viewModel.isLoading ? 0 : 1)
            .overlay {
                if viewModel.isLoading {
                    ProgressView()
                }
                
                if viewModel.hasError && !viewModel.isLoading {
                    ContentUnavailableView("Networking.Error.Title",
                                           systemImage: .SFImages.networkSlash,
                                           description: Text("Networking.Error.Description"))
                }
                
                if worldsFiltered.isEmpty && !viewModel.hasError && !viewModel.isLoading {
                    ContentUnavailableView("World.NoFound",
                                           systemImage: .SFImages.globe,
                                           description: Text("World.ErrorDescription"))
                }
            }
        }
    }
    
}

#Preview {
    WorldsListView(navigationPath: Binding.constant(NavigationPath()))
}
