//
//  FansitesView.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 20/01/24.
//

import SwiftUI

struct FansitesView: View {
    
    @State private var viewModel = FansitesViewModel()
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
        Form {
            Section("Promoted") {
                List(viewModel.fansites?.promoted ?? [], id: \.name) { promotedFansite in
                    FansiteRowView(model: promotedFansite, fansiteType: .promoted)
                        .contentShape(.rect)
                        .onTapGesture {
                            self.navigationPath.append(NavigationRoutes.Utils.Fansites.details(of: promotedFansite))
                        }
                }
            }
            
            Section("Supported") {
                List(viewModel.fansites?.supported ?? [], id: \.name) { supportedFansite in
                    FansiteRowView(model: supportedFansite, fansiteType: .supported)
                        .contentShape(.rect)
                        .onTapGesture {
                            self.navigationPath.append(NavigationRoutes.Utils.Fansites.details(of: supportedFansite))
                        }
                }
            }
        }
        .fontDesign(.serif)
        .opacity(viewModel.opacity)
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
    NavigationStack {
        FansitesView(navigationPath: Binding.constant(NavigationPath()))
    }
}
