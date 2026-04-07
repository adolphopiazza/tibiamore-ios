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
                    navigationPath.append(NavigationRoutes.Utils.Rashid.items)
                }, label: {
                    HStack {
                        Spacer()
                        
                        Text("Rashid.Items")
                        
                        Spacer()
                    }
                })
            }
            
            Section("Schedule") {
                ForEach(viewModel.rashidLocations, id: \.rawValue) { location in
                    LabeledContent(location.day, value: location.city)
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
                                       systemImage: .SFImages.networkSlash,
                                       description: Text("Error.TapRightIcon"))
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Note", systemImage: .SFImages.infoCircle) {
                    viewModel.isShowingInfo = true
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
