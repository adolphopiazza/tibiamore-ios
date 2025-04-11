//
//  HighscoresView.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 20/01/24.
//

import SwiftUI

struct HighscoresView: View {
    
    @Binding var navigationPath: NavigationPath
    @State private var viewModel = HighscoresViewModel()
    
    var body: some View {
        Form {
            Section("Filters") {
                filtersView
            }
            
            Section("Highscores") {
                List(Array(viewModel.highscores.enumerated()), id: \.offset) { (index, player) in
                    VStack(alignment: .leading) {
                        Text("\(index + 1). \(player.name)")
                            .font(.title)
                        
                        LabeledContent("Level", value: String(player.level))
                        LabeledContent("Vocation", value: player.vocation)
                        LabeledContent("World", value: player.world)
                        LabeledContent(viewModel.selectedCategory.title, value: String(player.value))
                            .font(.headline)
                    }
                    .contentShape(.rect)
                    .onTapGesture {
                        Task {
                            await viewModel.fetchCharacter(name: player.name)
                            
                            if let charModel = viewModel.characterModel {
                                self.navigationPath.append(NavigationRoutes.Utils.Highscores.characterDetails(with: charModel))
                            }
                        }
                    }
                }
            }
        }
        .disabled(viewModel.isLoadingCharacter)
        .opacity(viewModel.opacity)
        .fontDesign(.serif)
        .navigationTitle(viewModel.viewTitle)
        // yeah these onChanges are ugly as hell =[
        // maybe refactor to use combine (with subscribers?)
        .onChange(of: viewModel.selectedWorld, { _, _ in
            Task {
                do {
                    try await viewModel.fetchHighscores()
                } catch {
                    viewModel.hasError = true
                }
            }
        })
        .onChange(of: viewModel.selectedCategory, { _, _ in
            Task {
                do {
                    try await viewModel.fetchHighscores()
                } catch {
                    viewModel.hasError = true
                }
            }
        })
        .onChange(of: viewModel.selectedVocation, { _, _ in
            Task {
                do {
                    try await viewModel.fetchHighscores()
                } catch {
                    viewModel.hasError = true
                }
            }
        })
        .overlay {
            if viewModel.isLoading || viewModel.isLoadingCharacter {
                ProgressView()
            }
            
            if viewModel.hasError && !viewModel.isLoading {
                ContentUnavailableView("Networking.Error.Title",
                                       systemImage: .SFImages.networkSlash,
                                       description: Text("Error.TapRightIcon"))
            }
        }
        .toolbar {
            if viewModel.hasError {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Reload", systemImage: .SFImages.arrowClockwise) {
                        Task {
                            do {
                                try await viewModel.fetchWorlds()
                                try await viewModel.fetchHighscores()
                            } catch {
                                viewModel.hasError = true
                            }
                        }
                    }
                }
            }
        }
    }
    
    private var filtersView: some View {
        Group {
            Picker("World", selection: $viewModel.selectedWorld) {
                ForEach(viewModel.worlds, id: \.self) { world in
                    Text(world.localized)
                }
            }
            .pickerStyle(.navigationLink)
            
            Picker("Category", selection: $viewModel.selectedCategory) {
                ForEach(viewModel.categories, id: \.self) { category in
                    Text(category.title)
                }
            }
            .pickerStyle(.navigationLink)
            
            // Vocation filter is now restricted by TibiaData on the Production API,
            // on the DevAPI is works, but this environtment has restrictions
            // (1 request per second, 100 per hour)
            /*
            Picker("Vocation", selection: $viewModel.selectedVocation) {
                ForEach(viewModel.vocations, id: \.self) { vocation in
                    Text(vocation.title.localized)
                }
            }
            .pickerStyle(.menu)
             */
        }
    }
}

#Preview {
    NavigationStack {
        HighscoresView(navigationPath: Binding.constant(NavigationPath()))
    }
}
