//
//  CreaturesView.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 14/01/24.
//

import SwiftUI

struct CreaturesView: View {
    
    @State private var viewModel = CreaturesViewModel()
    @State private var searchedText: String = ""
    @Binding var navigationPath: NavigationPath
    
    private var filteredCreatures: [CreaturesDetailsModel] {
        if searchedText.isEmpty {
            return viewModel.creatures
        }
        
        return viewModel.creatures.filter({ $0.name.lowercased().contains(searchedText.lowercased()) })
    }
    
    var body: some View {
        List(filteredCreatures, id: \.name) { creature in
            CreaturesRowView(creature: creature)
                .contentShape(.rect)
                .onTapGesture {
                    navigationPath.append(NavigationRoutes.Utils.Creatures.details(of: creature.race))
                }
        }
        .navigationTitle(viewModel.viewTitle.localized)
        .refreshable {
            await viewModel.fetch(refreshing: true)
        }
        .searchable(text: $searchedText)
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
    CreaturesView(navigationPath: Binding.constant(NavigationPath()))
}
