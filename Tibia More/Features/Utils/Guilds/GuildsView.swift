//
//  GuildsView.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 21/01/24.
//

import SwiftUI

struct GuildsView: View {
    
    @State private var viewModel = GuildsViewModel()
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
        Form {
            Picker("World", selection: $viewModel.selectedWorld) {
                List(viewModel.worlds, id: \.self) { world in
                    Text(world)
                }
            }
            .pickerStyle(.navigationLink)
            
            Section("Active Guilds") {
                List(viewModel.guilds, id: \.name) { guild in
                    HStack(spacing: 16) {
                        AsyncImage(url: URL(string: guild.logoUrl ?? "")) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .frame(width: 50, height: 50)
                            } else if phase.error != nil {
                                Image(.guilddefault)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                            } else {
                                ProgressView()
                            }
                        }

                        VStack(alignment: .leading, spacing: 6) {
                            Text(guild.name)
                                .font(.title2)
                            
                            if !guild.description.isEmpty {
                                Text(guild.description)
                                    .font(.footnote)
                            }
                        }
                        
                        Spacer()
                        
                        Image(systemName: .SFImages.chevronRight)
                    }
                    .contentShape(.rect)
                    .onTapGesture {
                        self.navigationPath.append(NavigationRoutes.Utils.Guilds.details(of: guild.name))
                    }
                }
            }
        }
        .opacity(viewModel.opacity)
        .fontDesign(.serif)
        .navigationTitle(viewModel.viewTitle)
        .onChange(of: viewModel.selectedWorld) { _, _ in
            Task {
                await viewModel.fetchGuilds()
            }
        }
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
        GuildsView(navigationPath: Binding.constant(NavigationPath()))
    }
}
