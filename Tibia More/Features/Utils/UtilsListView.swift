//
//  UtilsListView.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 13/01/24.
//

import SwiftUI

struct UtilsListView: View {
    
    @State private var viewModel = UtilsListViewModel()
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            List(viewModel.menuItems, id: \.self) { item in
                UtilsListRowView(menuItem: item)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        navigationPath.append(NavigationRoutes.Utils.go(to: item))
                    }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("About", systemImage: .SFImages.infoCircle) {
                        navigationPath.append(NavigationRoutes.Utils.about)
                    }
                }
            }
            .navigationTitle(viewModel.viewTitle)
            .navigationDestination(for: NavigationRoutes.Utils.self) { route in
                switch route {
                case .about:
                    AboutView(navigationPath: $navigationPath)
                case .go(let destination):
                    switch destination {
                    case .rashid:
                        RashidView()
                    case .creatures:
                        CreaturesView(navigationPath: $navigationPath)
                    case .fansites:
                        FansitesView(navigationPath: $navigationPath)
                    case .guilds:
                        GuildsView(navigationPath: $navigationPath)
                    case .spells:
                        SpellsView(navigationPath: $navigationPath)
                    case .boostedBoss:
                        BoostedBossView()
                    case .boostedCreature:
                        BoostedCreatureView()
                    case .highscores:
                        HighscoresView()
                    case .killStatistics:
                        KillStatisticsView()
                    }
                }
            }
            .navigationDestination(for: NavigationRoutes.Utils.Creatures.self) { route in
                switch route {
                case .details(let race):
                    CreaturesDetailView(viewModel: CreaturesDetailViewModel(creatureRace: race))
                }
            }
            .navigationDestination(for: NavigationRoutes.Utils.Fansites.self) { route in
                switch route {
                case .details(let model):
                    FansitesDetailView(navigationPath: $navigationPath, model: model)
                case .browser(let url):
                    BrowserView(navigationPath: $navigationPath, url: url)
                }
            }
            .navigationDestination(for: NavigationRoutes.Utils.Guilds.self) { route in
                switch route {
                case .details(let name):
                    GuildDetailsView(viewModel: GuildDetailsViewModel(name: name))
                }
            }
            .navigationDestination(for: NavigationRoutes.Utils.About.self) { route in
                switch route {
                case .browser(let url):
                    BrowserView(navigationPath: $navigationPath, url: url)
                }
            }
        }
    }
}

#Preview {
    UtilsListView(navigationPath: Binding.constant(NavigationPath()))
}
