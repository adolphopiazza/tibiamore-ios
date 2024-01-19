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
                    DisclosureGroup("Creature Description") {
                        Text(creatureDescription)
                    }
                }
            }
            
            Section("About") {
                // Let's use worlds details view row but to-do: create a more generic
                // view to use across the app
                WorldsDetailsViewRow("Behaviour", value: viewModel.model?.behaviour, orientation: .vertical)
                WorldsDetailsViewRow("Hitpoints", value: viewModel.model?.hitpoints)
                WorldsDetailsViewRow("Loot List", value: viewModel.model?.lootList?.joined(separator: ", "), orientation: viewModel.model?.lootList?.count == 1 ? .horizontal : .vertical)
                WorldsDetailsViewRow("Experience Points", value: viewModel.model?.experiencePoints)
                WorldsDetailsViewRow("Immune to", value: viewModel.model?.immune?.joined(separator: ", "))
                WorldsDetailsViewRow("Strong against", value: viewModel.model?.strong?.joined(separator: ", "))
                WorldsDetailsViewRow("Weakness for", value: viewModel.model?.weakness?.joined(separator: ", "))
                
                if let seeInvisible = viewModel.model?.seeInvisible {
                    WorldsDetailsViewRow("See invisible", value: seeInvisible ? "✅" : "🚫")
                }
                
                if let beParalysed = viewModel.model?.beParalysed {
                    WorldsDetailsViewRow("Can be Paralysed", value: beParalysed ? "✅" : "🚫")
                }
                
                if let beSummoned = viewModel.model?.beSummoned, beSummoned {
                    DisclosureGroup("Summon with") {
                        Text("\(String(viewModel.model?.summonedMana ?? 0)) points of mana")
                    }
                }
                
                if let beConvinced = viewModel.model?.beConvinced, beConvinced {
                    DisclosureGroup("Convince with") {
                        Text("\(String(viewModel.model?.convincedMana ?? 0)) points of mana")
                    }
                }
            }
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
                ContentUnavailableView("Sorry, we got an error",
                                       systemImage: .SFImages.networkSlash,
                                       description: Text("Please pull-to-refresh to try again"))
            }
        }
    }
}

#Preview {
    CreaturesDetailView(viewModel: CreaturesDetailViewModel(creatureRace: "rotworm"))
}
