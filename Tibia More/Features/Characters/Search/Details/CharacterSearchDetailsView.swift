//
//  CharacterSearchDetailsView.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 17/12/23.
//

import SwiftUI

struct CharacterSearchDetailsView: View {
    
    var model: CharacterInfoModel
    
    var body: some View {
        List {
            characterInfoView
            
            formerNamesView
            
            formerWorldsView
            
            guildView
            
            housesView
        }
        .navigationTitle(model.name ?? "Character")
    }
    
    private var characterInfoView: some View {
        Section("Character Information") {
            CharacterSearchDetailsViewRow(title: "Name", value: model.name ?? "No name found")
            CharacterSearchDetailsViewRow(title: "Title", value: model.title ?? "None")
            CharacterSearchDetailsViewRow(title: "Unlocked Titles", value: String(model.unlockedTitles ?? 0))
            CharacterSearchDetailsViewRow(title: "Sex", value: model.sex ?? "No sex found")
            CharacterSearchDetailsViewRow(title: "Vocation", value: model.vocation ?? "No vocation found")
            CharacterSearchDetailsViewRow(title: "Level", value: String(model.level ?? 0))
            CharacterSearchDetailsViewRow(title: "Achievement Points", value: String(model.achievementPoints ?? 0))
            CharacterSearchDetailsViewRow(title: "World", value: model.world ?? "No world found")
            CharacterSearchDetailsViewRow(title: "Residence", value: model.residence ?? "No residence found")
            CharacterSearchDetailsViewRow(title: "Last Login", value: model.lastLogin ?? "No last login found")
            CharacterSearchDetailsViewRow(title: "Comment", value: model.comment ?? "No comment found", orientation: .vertical)
            CharacterSearchDetailsViewRow(title: "Account Status", value: model.accountStatus ?? "No account status found")
            
            if let deletionDate = model.deletionDate {
                CharacterSearchDetailsViewRow(title: "Deletion Date", value: deletionDate)
            }
            
            if let position = model.position {
                CharacterSearchDetailsViewRow(title: "Position", value: position)
            }
            
            if let marriedTo = model.marriedTo {
                CharacterSearchDetailsViewRow(title: "Married to", value: marriedTo)
            }
            
            if let traded = model.traded {
                CharacterSearchDetailsViewRow(title: "Traded", value: traded ? "✅" : "🚫")
            }
        }
    }
    
    private var formerNamesView: some View {
        Group {
            if let names = model.formerNames {
                Section("Former Names") {
                    ForEach(names, id: \.self) { name in
                        Text(name)
                            .fontDesign(.serif)
                    }
                }
            }
        }
    }
    
    private var formerWorldsView: some View {
        Group {
            if let worlds = model.formerWorlds {
                Section("Former Worlds") {
                    ForEach(worlds, id: \.self) { world in
                        Text(world)
                            .fontDesign(.serif)
                    }
                }
            }
        }
    }
    
    private var guildView: some View {
        Group {
            if let guild = model.guild, let guildName = guild.name {
                Section("Guild") {
                    CharacterSearchDetailsViewRow(title: "Name", value: guildName)
                    CharacterSearchDetailsViewRow(title: "Rank", value: guild.rank ?? "No guild rank")
                }
            }
        }
    }
    
    private var housesView: some View {
        Group {
            if let houses = model.houses {
                ForEach(houses, id: \.houseid) { house in
                    Section("House") {
                        CharacterSearchDetailsViewRow(title: "Name", value: house.name ?? "N/A")
                        CharacterSearchDetailsViewRow(title: "Paid Until", value: house.paid ?? "N/A")
                        CharacterSearchDetailsViewRow(title: "Town", value: house.town ?? "N/A")
                    }
                }
            }
        }
    }
    
}

#Preview {
    CharacterSearchDetailsView(model: CharacterInfoModel(accountStatus: nil,
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
                                                         world: "Belobra"))
}
