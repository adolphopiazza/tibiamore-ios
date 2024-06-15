//
//  BoostedBossView.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 19/01/24.
//

import SwiftUI

struct BoostedBossView: View {
    
    @State private var viewModel = BoostedBossViewModel()
    
    var body: some View {
        Form {
            boostedBossView
                .padding(.vertical, 16)
            
            Section("Boostable Bosses") {
                ForEach(viewModel.boostedBoss?.boostableBossList ?? [], id: \.name) { boostableBoss in
                    HStack(spacing: 16) {
                        AsyncImage(url: URL(string: boostableBoss.imageUrl)!) { image in
                            image
                                .resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 50, height: 50, alignment: .center)

                        Text(boostableBoss.name)
                            .font(.title2)
                    }
                }
            }
        }
        .opacity(viewModel.opacity)
        .fontDesign(.serif)
        .navigationTitle(viewModel.viewTitle)
        .overlay {
            if viewModel.isLoading {
                ProgressView()
            }
            
            if viewModel.hasError && !viewModel.isLoading {
                ContentUnavailableView("Networking.Error.Title",
                                       systemImage: .SFImages.networkSlash)
            }
        }
    }
    
    private var boostedBossView: some View {
        HStack {
            Spacer()
            
            VStack(alignment: .center) {
                Text(viewModel.boostedBoss?.boosted.name ?? "")
                    .font(.title)
                
                if let url = URL(string: viewModel.boostedBoss?.boosted.imageUrl ?? "") {
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
    }
}

#Preview {
    BoostedBossView()
}
