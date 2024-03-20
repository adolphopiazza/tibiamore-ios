//
//  CharacterSearchDetailsOtherCharactersView.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 22/12/23.
//

import SwiftUI

struct CharacterSearchDetailsOtherCharactersView: View {
    
    let characters: [OtherCharactersModel]
    let action: (String) -> ()
    
    var body: some View {
        ForEach(characters, id: \.name) { character in
            if let name = character.name, !name.isEmpty,
               let main = character.main,
               let world = character.world, !world.isEmpty,
               let status = character.status, !status.isEmpty {
                HStack {
                    Text(name)
                        .foregroundStyle(status == "online" ? .green : .primary)
                    
                    if main {
                        Image(.mainCharacter)
                    }
                    
                    Spacer()
                    
                    Text(world)
                        .foregroundStyle(.secondary)
                }
                .fontDesign(.serif)
                .contentShape(.rect)
                .onTapGesture {
                    action(name)
                }
            }
        }
    }
    
}

#Preview {
    CharacterSearchDetailsOtherCharactersView(characters: [OtherCharactersModel(deleted: nil,
                                                                                main: true,
                                                                                name: "Otavio Invencivel",
                                                                                position: nil,
                                                                                status: "online",
                                                                                traded: nil,
                                                                                world: "Inabra")], 
                                              action: {_ in })
}
