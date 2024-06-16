//
//  KillStatisticsView.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 20/01/24.
//

import SwiftUI

struct KillStatisticsView: View {
    
    @State private var viewModel = KillStatisticsViewModel()
    @State private var searchedText: String = ""
    
    private var filteredCreatures: [KillStatisticsDataModel] {
        if searchedText.isEmpty {
            return viewModel.killStatistics?.entries ?? []
        }
        
        return viewModel.killStatistics?.entries.filter({ entry in
            guard let race = entry.race else { return false }
            return race.contains(searchedText.lowercased())
        }) ?? []
    }
    
    var body: some View {
        Form {
            if searchedText.isEmpty {
                Picker("World", selection: $viewModel.selectedWorld) {
                    ForEach(viewModel.worlds, id: \.self) { world in
                        Text(world)
                    }
                }
                .pickerStyle(.navigationLink)
                
                Section("Totals") {
                    if let totals = viewModel.killStatistics?.total {
                        KillStatisticsTotalsView(model: totals)
                    }
                }
            }
            
            Section("Creatures") {
                List(filteredCreatures, id: \.self) { entry in
                    VStack(alignment: .leading) {
                        Text(entry.race?.capitalized ?? "")
                            .font(.title)
                        
                        KillStatisticsTotalsView(model: entry)
                    }
                }
            }
        }
        .fontDesign(.serif)
        .opacity(viewModel.opacity)
        .navigationTitle(viewModel.viewTitle.localized)
        .searchable(text: $searchedText)
        .onChange(of: viewModel.selectedWorld, { _, _ in
            Task {
                await self.viewModel.fetchKillStatistics()
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
    
}

#Preview {
    NavigationStack {
        KillStatisticsView()
    }
}
