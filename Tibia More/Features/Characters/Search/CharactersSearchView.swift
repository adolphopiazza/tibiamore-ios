//
//  CharactersSearchView.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 17/12/23.
//

import SwiftUI

struct CharactersSearchView: View {
    
    @State private var viewModel = CharactersSearchViewModel()
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                TextField("Insert your character name", text: $viewModel.characterName)
                    .textFieldStyle(CharacterSearchTextFieldStyle())
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.words)
                
                Button(action: {
                    Task {
                        await viewModel.fetchAllInfo()
                        
                        if let model = viewModel.model {
                            self.navigationPath.append(NavigationRoutes.Characters.detailsFromSearch(with: model))
                        }
                    }
                }, label: {
                    Text("exiva \"\(viewModel.characterName)\"")
                })
                .buttonStyle(TibiaMorePrimaryButtonStyle())
                .disabled(viewModel.characterName.isEmpty)
            }
            .padding([.horizontal, .top], 20)
        }
        .navigationTitle(viewModel.viewTitle)
        .disabled(viewModel.isLoading)
        .alert("Sorry 🙁", isPresented: $viewModel.hasError) {
            Button("OK") {
                viewModel.characterName.removeAll()
            }
        } message: {
            Text("\nIt seems this character does not exist\nPlease try again")
        }
        .overlay {
            if viewModel.isLoading {
                ProgressView()
            }
        }
        .onSubmit {
            Task {
                await viewModel.fetchAllInfo()
                
                if let model = viewModel.model {
                    self.navigationPath.append(NavigationRoutes.Characters.detailsFromSearch(with: model))
                }
            }
        }
    }
    
}

#Preview {
    CharactersSearchView(navigationPath: Binding.constant(NavigationPath()))
}
