//
//  SpellsView.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 18/02/24.
//

import SwiftUI

struct SpellsView: View {
    
    @State private var viewModel = SpellsViewModel()
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
        Form {
            Text("Hello, Spells!")
        }
        .navigationTitle(viewModel.viewTitle)
    }
    
}

#Preview {
    SpellsView(navigationPath: Binding.constant(NavigationPath()))
}
