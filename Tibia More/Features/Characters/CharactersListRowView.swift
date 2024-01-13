//
//  CharactersListRowView.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 05/01/24.
//

import SwiftUI

struct CharactersListRowView: View {
    
    var model: CharacterInfoModel
    var isOnline: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Circle()
                    .fill(isOnline ? .green : .red)
                    .frame(width: 10)
                
                Text(model.name ?? "")
                    .font(.title)
                
                Spacer()
                
                Text(model.accountStatus ?? "")
                    .font(.footnote)
                    .padding(4)
                    .background {
                        RoundedRectangle(cornerRadius: 4)
                            .foregroundStyle(model.accountStatus ?? "" == "Free Account" ? .green : .orange)
                    }
            }
            .fontWeight(.light)
            .fontDesign(.serif)
            .padding(.bottom, 8)
            
            CharacterSearchDetailsViewRow(title: "Level", value: String(model.level ?? 0))
            CharacterSearchDetailsViewRow(title: "Vocation", value: model.vocation ?? "")
            CharacterSearchDetailsViewRow(title: "Sex", value: model.sex ?? "")
            CharacterSearchDetailsViewRow(title: "Last seen", value: model.lastLogin?.formatDate(with: .yyyyMMddTHHmmssZ) ?? "")
            CharacterSearchDetailsViewRow(title: "World", value: model.world ?? "")
        }
    }
}

#Preview {
    CharactersListRowView(model: CharacterInfoModel(accountStatus: "Free account",
                                                    achievementPoints: nil,
                                                    comment: nil,
                                                    deletionDate: nil,
                                                    formerNames: nil,
                                                    formerWorlds: nil,
                                                    guild: nil,
                                                    houses: nil,
                                                    lastLogin: nil,
                                                    level: 69,
                                                    marriedTo: nil,
                                                    name: "Hirko",
                                                    position: nil,
                                                    residence: nil,
                                                    sex: "Male",
                                                    title: nil,
                                                    traded: nil,
                                                    unlockedTitles: nil,
                                                    vocation: "Sorcerer",
                                                    world: "Belobra"))
}
