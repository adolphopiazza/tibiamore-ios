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
                await viewModel.fetchHighscores()
            }
        })
        .onChange(of: viewModel.selectedCategory, { _, _ in
            Task {
                await viewModel.fetchHighscores()
            }
        })
        .onChange(of: viewModel.selectedVocation, { _, _ in
            Task {
                await viewModel.fetchHighscores()
            }
        })
        .overlay {
            if viewModel.isLoading || viewModel.isLoadingCharacter {
                ProgressView()
            }
            
            if viewModel.hasError && !viewModel.isLoading {
                ContentUnavailableView("Sorry, we got an error", 
                                       image: .SFImages.networkSlash,
                                       description: Text("Try to refresh the page tapping on the top right icon"))
            }
        }
        .toolbar {
            if viewModel.hasError {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Reload", systemImage: .SFImages.arrowClockwise) {
                        Task {
                            await viewModel.fetchWorlds()
                            await viewModel.fetchHighscores()
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
                    Text(world)
                }
            }
            .pickerStyle(.navigationLink)
            
            Picker("Category", selection: $viewModel.selectedCategory) {
                ForEach(viewModel.categories, id: \.self) { category in
                    Text(category.title)
                }
            }
            .pickerStyle(.navigationLink)
            
            Picker("Vocation", selection: $viewModel.selectedVocation) {
                ForEach(viewModel.vocations, id: \.self) { vocation in
                    Text(vocation.title)
                }
            }
            .pickerStyle(.menu)
        }
    }
}

#Preview {
    NavigationStack {
        HighscoresView(navigationPath: Binding.constant(NavigationPath()))
    }
}
