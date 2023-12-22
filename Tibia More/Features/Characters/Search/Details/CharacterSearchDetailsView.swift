//
//  CharacterSearchDetailsView.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 17/12/23.
//

import SwiftUI

struct CharacterSearchDetailsView: View {
    
    var model: CharacterModel
    
    var body: some View {
        List {
            characterInfoView
        }
        .navigationTitle(model.character.name ?? "Character")
    }
    
    private var characterInfoView: some View {
        Section("Character Information") {
            CharacterSearchDetailsViewRow(title: "Name", value: model.character.name ?? "No name found")
            
            if let formerNames = model.character.formerNames {
                CharacterSearchDetailsViewRow(title: "Former Names", value: formerNames.joined(separator: ", "), orientation: .vertical)
            }
            
            CharacterSearchDetailsViewRow(title: "Title", value: model.character.title ?? "None")
            CharacterSearchDetailsViewRow(title: "Unlocked Titles", value: String(model.character.unlockedTitles ?? 0))
            CharacterSearchDetailsViewRow(title: "Sex", value: model.character.sex ?? "No sex found")
            CharacterSearchDetailsViewRow(title: "Vocation", value: model.character.vocation ?? "No vocation found")
            CharacterSearchDetailsViewRow(title: "Level", value: String(model.character.level ?? 0))
            CharacterSearchDetailsViewRow(title: "Achievement Points", value: String(model.character.achievementPoints ?? 0))
            CharacterSearchDetailsViewRow(title: "World", value: model.character.world ?? "No world found")
            
            if let formerWorlds = model.character.formerWorlds {
                CharacterSearchDetailsViewRow(title: "Former Worlds", value: formerWorlds.joined(separator: ", "), orientation: .vertical)
            }
            
            CharacterSearchDetailsViewRow(title: "Residence", value: model.character.residence ?? "No residence found")
            
            if let houses = model.character.houses {
                ForEach(houses, id: \.houseid) { house in
                    if let houseName = house.name, !houseName.isEmpty,
                       let houseTown = house.town, !houseTown.isEmpty,
                       let housePaid = house.paid, !housePaid.isEmpty {
                            CharacterSearchDetailsViewRow(title: "House",
                                                          value: "\(houseName) (\(houseTown)) is paid until \(housePaid)",
                                                          orientation: .vertical)
                    }
                }
            }
            
            if let guild = model.character.guild {
                if let guildRank = guild.rank, !guildRank.isEmpty,
                   let guildName = guild.name, !guildName.isEmpty {
                        CharacterSearchDetailsViewRow(title: "Guild Membership", value: "\(guildRank) of the \(guildName)", orientation: .vertical)
                }
            }
            
            CharacterSearchDetailsViewRow(title: "Last Login", value: model.character.lastLogin ?? "No last login found")
            CharacterSearchDetailsViewRow(title: "Comment", value: model.character.comment ?? "No comment found", orientation: .vertical)
            CharacterSearchDetailsViewRow(title: "Account Status", value: model.character.accountStatus ?? "No account status found")
            
            if let deletionDate = model.character.deletionDate {
                CharacterSearchDetailsViewRow(title: "Deletion Date", value: deletionDate)
            }
            
            if let position = model.character.position {
                CharacterSearchDetailsViewRow(title: "Position", value: position)
            }
            
            if let marriedTo = model.character.marriedTo {
                CharacterSearchDetailsViewRow(title: "Married to", value: marriedTo)
            }
            
            if let traded = model.character.traded {
                CharacterSearchDetailsViewRow(title: "Traded", value: traded ? "✅" : "🚫")
            }
        }
    }
    
}

#Preview {
    CharacterSearchDetailsView(model: CharacterModel(character: CharacterInfoModel(accountStatus: nil,
                                                                                   achievementPoints: nil,
                                                                                   comment: "Some random comment",
                                                                                   deletionDate: nil,
                                                                                   formerNames: ["Name 1", "Name 2"],
                                                                                   formerWorlds: ["World 1", "World 2", "World 3"],
                                                                                   guild: GuildModel(name: "The guilders", rank: "Ancient"),
                                                                                   houses: [HouseModel(houseid: nil, name: "One way street", paid: "2023-12-23", town: "Venore")],
                                                                                   lastLogin: nil,
                                                                                   level: 191,
                                                                                   marriedTo: nil,
                                                                                   name: "bidomeister",
                                                                                   position: nil,
                                                                                   residence: "Yalahar",
                                                                                   sex: "Male",
                                                                                   title: nil,
                                                                                   traded: nil,
                                                                                   unlockedTitles: nil,
                                                                                   vocation: "Master Sorcerer",
                                                                                   world: "Belobra"),
                                                     accountInformation: nil,
                                                     achievements: nil,
                                                     otherCharacters: nil))
}
