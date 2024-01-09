//
//  WorldsListView.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 04/12/23.
//

import SwiftUI

struct WorldsListView: View {
    
    @State private var viewModel = WorldsListViewModel()
    
    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            Form {
                Section("About") {
                    LabeledContent("Players Online", value: String(viewModel.model?.playersOnline ?? 0))
                    LabeledContent("Record Players", value: String(viewModel.model?.recordPlayers ?? 0))
                    LabeledContent("Record Date", value: viewModel.model?.recordDate.formatDate(with: .yyyyMMddTHHmmssZ) ?? "")
                }
                
                Section("Worlds") {
                    List(viewModel.model?.regularWorlds ?? [], id: \.name) { world in
                        WorldsListViewRow(model: world)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                viewModel.navigationPath.append(NavigationRoutes.Worlds.details(of: world.name))
                            }
                    }
                }
            }
            .fontDesign(.serif)
            .navigationTitle(viewModel.viewTitle)
            .refreshable {
                viewModel.model = nil
                await viewModel.fetch()
            }
            .navigationDestination(for: NavigationRoutes.Worlds.self, destination: { route in
                switch route {
                case .details(let world):
                    WorldsDetailsView(viewModel: WorldsDetailsViewModel(world: world))
                }
            })
            .opacity(viewModel.isLoading ? 0 : 1)
            .overlay {
                if viewModel.isLoading {
                    ProgressView()
                }
            }
        }
    }
    
}

#Preview {
    WorldsListView()
}
