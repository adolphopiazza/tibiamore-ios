//
//  WorldsDetailsView.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 07/01/24.
//

import SwiftUI

struct WorldsDetailsView: View {
    
    @State var viewModel: WorldsDetailsViewModel
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
        Form {
            Section("About") {
                WorldsDetailsViewRow("Status", value: viewModel.model?.status)
                WorldsDetailsViewRow("Players Online", value: viewModel.model?.playersOnline)
                WorldsDetailsViewRow("Online Record", value: viewModel.model?.recordPlayers)
                WorldsDetailsViewRow("Record Date", value: viewModel.model?.recordDate.formatDate(with: .yyyyMMddTHHmmssZ))
                WorldsDetailsViewRow("Creation Date", value: viewModel.model?.creationDate.formatDate(with: .yyyyMM))
                WorldsDetailsViewRow("Location", value: viewModel.model?.location)
                WorldsDetailsViewRow("PvP Type", value: viewModel.model?.pvpType)
                WorldsDetailsViewRow("Transfer Type", value: viewModel.model?.transferType)
                WorldsDetailsViewRow("World Quest Titles", value: viewModel.model?.worldQuestTitles.joined(separator: ", "), orientation: .vertical)
                WorldsDetailsViewRow("BattlEye Status", value: viewModel.model?.battleyeDate.formatDate(with: .yyyyMMdd))
                WorldsDetailsViewRow("Game World Type", value: viewModel.model?.gameWorldType)
            }
            .opacity(viewModel.opacity)
            
            Section("Online Players") {
                List(viewModel.model?.onlinePlayers ?? [], id: \.name) { player in
                    VStack(alignment: .leading) {
                        Text(player.name)
                            .font(.title)
                        
                        LabeledContent("Level", value: String(player.level))
                        LabeledContent("Vocation", value: player.vocation)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        Task {
                            await viewModel.fetchCharacter(name: player.name)
                            
                            if let model = viewModel.characterModel, !viewModel.errorLoadingCharacter {
                                self.navigationPath.append(NavigationRoutes.Worlds.characterDetails(with: model))
                            }
                        }
                    }
                }
            }
            .opacity(viewModel.opacity)
        }
        .disabled(viewModel.isLoadingCharacter)
        .fontDesign(.serif)
        .navigationTitle(viewModel.model?.name ?? "")
        .refreshable {
            viewModel.model = nil
            await viewModel.fetch(viewModel.world)
        }
        .overlay {
            if viewModel.isLoading || viewModel.isLoadingCharacter {
                ProgressView()
            }
            
            if viewModel.model == nil && !viewModel.isLoading {
                ContentUnavailableView("No data available 😟",
                                       systemImage: .SFImages.networkSlash,
                                       description: Text("Please pull-to-refresh to get new data"))
            }
        }
        .alert("Sorry 😞", isPresented: $viewModel.errorLoadingCharacter) {
            Button("OK", action: {
                viewModel.errorLoadingCharacter = false
            })
        } message: {
            Text("We were unable to get this player data\nPlease try again")
        }

    }
    
}

#Preview {
    WorldsDetailsView(viewModel: WorldsDetailsViewModel(world: "Belobra"),
                      navigationPath: Binding.constant(NavigationPath()))
}
