//
//  CreaturesDetailView.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 15/01/24.
//

import SwiftUI

struct CreaturesDetailView: View {
    
    @State var viewModel: CreaturesDetailViewModel
    
    var body: some View {
        Form {
            Section {
                if let image = viewModel.model?.imageUrl, let url = URL(string: image) {
                    AsyncImage(url: url, scale: 0.7) { image in
                        HStack {
                            Spacer()
                            image
                            Spacer()
                        }
                    } placeholder: {
                        ProgressView()
                    }

                }

                if let creatureDescription = viewModel.model?.description {
                    DisclosureGroup("Creature.Description") {
                        Text(creatureDescription)
                    }
                }
            }
            
            CreaturesDetailAboutView(creature: viewModel.model)
                .opacity(viewModel.hasError || viewModel.isLoading ? 0 : 1)
        }
        .fontDesign(.serif)
        .navigationTitle(viewModel.model?.name ?? "")
        .refreshable {
            viewModel.model = nil
            await viewModel.fetch(race: viewModel.race)
        }
        .overlay {
            if viewModel.isLoading {
                ProgressView()
            }
            
            if viewModel.hasError && !viewModel.isLoading {
                ContentUnavailableView("Networking.Error.Title",
                                       systemImage: .SFImages.networkSlash,
                                       description: Text("Networking.Error.Description"))
            }
        }
    }
}

#Preview {
    CreaturesDetailView(viewModel: CreaturesDetailViewModel(creatureRace: "rotworm"))
}
