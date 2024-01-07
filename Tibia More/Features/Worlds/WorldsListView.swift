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
                    LabeledContent("Players Online", value: String(viewModel.model.playersOnline))
                    LabeledContent("Record Players", value: String(viewModel.model.recordPlayers))
                    LabeledContent("Record Date", value: viewModel.model.recordDate.formatDate(with: .yyyyMMddTHHmmssZ))
                }
                
                Section("Worlds") {
                    List(viewModel.model.regularWorlds, id: \.name) { world in
                        WorldsListViewRow(model: world)
                    }
                }
            }
            .fontDesign(.serif)
            .navigationTitle(viewModel.viewTitle)
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
