//
//  RashidView.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 14/01/24.
//

import SwiftUI

struct RashidView: View {
    
    @State private var viewModel = RashidViewModel()
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
        Form {
            VStack(alignment: .center) {
                Image(.rashid)
                    .resizable()
                    .frame(width: 200, height: 200, alignment: .center)
                
                Text("Rashid.Description")
                    .font(.title3)
                    .multilineTextAlignment(.center)
            }
            
            Section("Today") {
                LabeledContent("Rashid.Location") {
                    Text(viewModel.rashidCity)
                        .font(.headline)
                }
                
                Button(action: {
                    navigationPath.append(NavigationRoutes.Utils.Rashid.items(with: viewModel.rashidItems))
                }, label: {
                    HStack {
                        Spacer()
                        
                        Text("Rashid.Items")
                        
                        Spacer()
                    }
                })
            }
            
            Section("Schedule") {
                LabeledContent("Mondays", value: "Svargrond")
                LabeledContent("Tuesdays", value: "Liberty Bay")
                LabeledContent("Wednesdays", value: "Port Hope")
                LabeledContent("Thursdays", value: "Ankrahmun")
                LabeledContent("Fridays", value: "Darashia")
                LabeledContent("Saturdays", value: "Edron")
                LabeledContent("Sundays", value: "Carlin")
            }
        }
        .opacity(viewModel.opacity)
        .fontDesign(.serif)
        .navigationTitle(viewModel.viewTitle)
        .task {
            await viewModel.fetch()
        }
        .overlay {
            if viewModel.isLoading {
                ProgressView()
            }
            
            if viewModel.hasError && !viewModel.isLoading {
                ContentUnavailableView("Networking.Error.Title",
                                       systemImage: .SFImages.networkSlash,
                                       description: Text("Error.TapRightIcon"))
            }
        }
        .toolbar {
            if !viewModel.hasError {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Note", systemImage: .SFImages.infoCircle) {
                        viewModel.isShowingInfo = true
                    }
                }
            } else {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Reload", systemImage: .SFImages.arrowClockwise) {
                        Task {
                            await viewModel.fetch()
                        }
                    }
                }
            }
        }
        .alert("About", isPresented: $viewModel.isShowingInfo) {
            Button("OK", action: {})
        } message: {
            Text("Rashid.Alert")
        }
    }
    
}

#Preview {
    NavigationStack {
        RashidView(navigationPath: Binding.constant(NavigationPath()))
    }
}
