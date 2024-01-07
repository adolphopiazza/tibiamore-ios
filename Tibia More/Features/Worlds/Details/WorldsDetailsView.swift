//
//  WorldsDetailsView.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 07/01/24.
//

import SwiftUI

struct WorldsDetailsView: View {
    
    @State var viewModel: WorldsDetailsViewModel
    
    var body: some View {
        List {
            LabeledContent("Players Online", value: String(viewModel.model?.playersOnline ?? 0))
        }
        .navigationTitle(viewModel.model?.name ?? "")
        .overlay {
            if viewModel.isLoading {
                ProgressView()
            }
        }
    }
    
}

#Preview {
    WorldsDetailsView(viewModel: WorldsDetailsViewModel(world: "Belobra"))
}
