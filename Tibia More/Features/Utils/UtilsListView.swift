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
            .navigationTitle(viewModel.viewTitle)
            .navigationDestination(for: NavigationRoutes.Utils.self) { route in
                switch route {
                case .go(let destination):
                    switch destination {
                    case .rashid:
                        Text("Rashid")
                    case .creatures:
                        Text("Creatures")
                    case .boostedBoss:
                        Text("Boosted Boss")
                    case .boostedCreature:
                        Text("Boosted Creature")
                    case .highscores:
                        Text("Highscores")
                    case .killStatistics:
                        Text("Kill Statistics")
                    case .fansites:
                        Text("Fansites")
                    case .guilds:
                        Text("Guilds")
                    }
                }
            }
        }
    }
}

#Preview {
    UtilsListView(navigationPath: Binding.constant(NavigationPath()))
}
