//
//  SpellsView.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 18/02/24.
//

import SwiftUI

struct SpellsView: View {
    
    @State private var viewModel = SpellsViewModel()
    
    private var filteredSpells: [SpellsModel] {
        if viewModel.filteredVocation == .all {
            return viewModel.spells.sorted { prev, next in
                if !viewModel.sortLevel {
                    return false
                }
                
                return prev.spellInformation.level < next.spellInformation.level
            }
        }
        
        let filtered = viewModel.spells.filter { spell in
            let vocation = viewModel.filteredVocation.title.replacingOccurrences(of: "s", with: "")
            return spell.spellInformation.vocation.contains(vocation)
        }
        
        return filtered.sorted { prev, next in
            if !viewModel.sortLevel {
                return false
            }
            
            return prev.spellInformation.level < next.spellInformation.level
        }
    }
    
    var body: some View {
        Form {
            Section {
                Picker("Vocation", selection: $viewModel.filteredVocation) {
                    ForEach(viewModel.vocations, id: \.self) { vocation in
                        Text(vocation.title)
                    }
                }
                .pickerStyle(.menu)
                
                Toggle("Sort by Level", isOn: $viewModel.sortLevel)
                    .tint(.accent)
            }
            
            List(filteredSpells, id: \.spellId) { spell in
                SpellsRowView(spell: spell)
            }
        }
        .fontDesign(.serif)
        .navigationTitle(viewModel.viewTitle)
        .task {
            await viewModel.fetchSpells()
        }
    }
    
}

#Preview {
    NavigationStack {
        SpellsView()
    }
}
