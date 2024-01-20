//
//  BoostedCreatureView.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 19/01/24.
//

import SwiftUI

struct BoostedCreatureView: View {
    
    @State private var viewModel = BoostedCreatureViewModel()
    
    var body: some View {
        Form {
            HStack {
                Spacer()
                
                VStack {
                    Text(viewModel.boostedCreature?.name ?? "")
                        .font(.title)
                        .padding(.top, 16)
                    
                    if let url = URL(string: viewModel.boostedCreature?.imageUrl ?? "") {
                        AsyncImage(url: url, scale: 0.7) { image in
                            HStack {
                                image
                            }
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
                
                Spacer()
            }
            
            DisclosureGroup("Creature Description") {
                Text(viewModel.boostedCreature?.description ?? "")
            }
            
            CreaturesDetailAboutView(creature: viewModel.boostedCreature)
        }
        .opacity(viewModel.opacity)
        .fontDesign(.serif)
        .navigationTitle(viewModel.viewTitle)
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
    BoostedCreatureView()
}
