//
//  HighscoresView.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 20/01/24.
//

import SwiftUI

struct HighscoresView: View {
    
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
                }
            }
        }
        .opacity(viewModel.hasError || viewModel.isLoading ? 0 : 1)
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
            if viewModel.isLoading {
                ProgressView()
            }
            
            if viewModel.hasError && !viewModel.isLoading {
                ContentUnavailableView("Sorry, we got an error",
                                       systemImage: .SFImages.networkSlash)
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
        HighscoresView()
    }
}
