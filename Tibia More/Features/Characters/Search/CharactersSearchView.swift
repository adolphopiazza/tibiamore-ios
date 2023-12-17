//
//  CharactersSearchView.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 17/12/23.
//

import SwiftUI

struct CharactersSearchView: View {
    
    @State private var viewModel = CharactersSearchViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                TextField("Insert your character name", text: $viewModel.characterName)
                    .textFieldStyle(CharacterSearchTextFieldStyle())
                    .autocorrectionDisabled()
                
                Button(action: {
                    Task {
                        await viewModel.fetch()
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
        .alert("Error 🙁", isPresented: $viewModel.hasError) {
            Button("OK") {
                viewModel.characterName.removeAll()
            }
        } message: {
            Text("Unable to find this character\n\nPlease try again!")
        }
        .overlay {
            if viewModel.isLoading {
                ProgressView()
            }
        }
    }
    
}

#Preview {
    CharactersSearchView()
}
