//
//  CharacterSearchDetailsView.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 17/12/23.
//

import SwiftUI

struct CharacterSearchDetailsView: View {
    
    @Binding var navigationPath: NavigationPath
    @State private var removeCharacter: Bool = false
    
    var viewModel: CharacterSearchDetailsViewModel
    
    var body: some View {
        List {
            characterInfoView
            
            achievementsView
            
            accountInformationView
            
            otherCharactersView
        }
        .navigationTitle(viewModel.model.character.name ?? "Character")
        .alert("Remove this character from the list?", isPresented: $removeCharacter, actions: {
            Button("Yes", role: .destructive) {
                if DefaultStorage.shared.removeString(value: viewModel.model.character.name ?? "", from: .character) {
                    navigationPath.removeLast(navigationPath.count)
                }
            }
        }, message: {
            Text("This action cannot be undone")
        })
        .toolbar {
            if viewModel.isFromSearch {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save on list") {
                        self.save()
                    }
                }
            } else if !viewModel.isFromWorlds {
                ToolbarItem(placement: .topBarTrailing) {
                    HStack {
                        Button("All characters") {
                            self.navigationPath.removeLast(self.navigationPath.count)
                        }
                        
                        Button("Remove character", systemImage: .SFImages.trash) {
                            self.removeCharacter = true
                        }
                    }
                }
            }
        }
    }
    
    private var characterInfoView: some View {
        Section("Character Information") {
            CharacterSearchDetailsViewRow(title: "Name", value: viewModel.model.character.name ?? "No name found")
            
            if let formerNames = viewModel.model.character.formerNames {
                CharacterSearchDetailsViewRow(title: "Former Names", value: formerNames.joined(separator: ", "), orientation: .vertical)
            }
            
            CharacterSearchDetailsViewRow(title: "Title", value: viewModel.model.character.title ?? "None")
            CharacterSearchDetailsViewRow(title: "Unlocked Titles", value: String(viewModel.model.character.unlockedTitles ?? 0))
            CharacterSearchDetailsViewRow(title: "Sex", value: viewModel.model.character.sex ?? "No sex found")
            CharacterSearchDetailsViewRow(title: "Vocation", value: viewModel.model.character.vocation ?? "No vocation found")
            CharacterSearchDetailsViewRow(title: "Level", value: String(viewModel.model.character.level ?? 0))
            CharacterSearchDetailsViewRow(title: "Achievement Points", value: String(viewModel.model.character.achievementPoints ?? 0))
            CharacterSearchDetailsViewRow(title: "World", value: viewModel.model.character.world ?? "No world found")
            
            if let formerWorlds = viewModel.model.character.formerWorlds {
                CharacterSearchDetailsViewRow(title: "Former Worlds", value: formerWorlds.joined(separator: ", "), orientation: .vertical)
            }
            
            CharacterSearchDetailsViewRow(title: "Residence", value: viewModel.model.character.residence ?? "No residence found")
            
            if let houses = viewModel.model.character.houses {
                ForEach(houses, id: \.houseid) { house in
                    if let houseName = house.name, !houseName.isEmpty,
                       let houseTown = house.town, !houseTown.isEmpty,
                       let housePaid = house.paid, !housePaid.isEmpty {
                            CharacterSearchDetailsViewRow(title: "House",
                                                          value: "\(houseName) (\(houseTown)) is paid until \(housePaid.formatDate(with: .yyyyMMdd))",
                                                          orientation: .vertical)
                    }
                }
            }
            
            if let guild = viewModel.model.character.guild {
                if let guildRank = guild.rank, !guildRank.isEmpty,
                   let guildName = guild.name, !guildName.isEmpty {
                        CharacterSearchDetailsViewRow(title: "Guild Membership", value: "\(guildRank) of the \(guildName)", orientation: .vertical)
                }
            }
            
            CharacterSearchDetailsViewRow(title: "Last Login", value: viewModel.model.character.lastLogin?.formatDate(with: .yyyyMMddTHHmmssZ) ?? "No last login found")
            
            if let comment = viewModel.model.character.comment {
                CharacterSearchDetailsViewRow(title: "Comment", value: comment, orientation: .vertical)
            }
            
            CharacterSearchDetailsViewRow(title: "Account Status", value: viewModel.model.character.accountStatus ?? "No account status found")
            
            if let deletionDate = viewModel.model.character.deletionDate {
                CharacterSearchDetailsViewRow(title: "Deletion Date", value: deletionDate.formatDate(with: .yyyyMMddTHHmmssZ))
            }
            
            if let position = viewModel.model.character.position {
                CharacterSearchDetailsViewRow(title: "Position", value: position)
            }
            
            if let marriedTo = viewModel.model.character.marriedTo {
                CharacterSearchDetailsViewRow(title: "Married to", value: marriedTo)
            }
            
            if let traded = viewModel.model.character.traded {
                CharacterSearchDetailsViewRow(title: "Traded", value: traded ? "✅" : "🚫")
            }
        }
    }
    
    private var achievementsView: some View {
        Group {
            if let achievements = viewModel.model.achievements {
                Section("Account Achievements") {
                    CharacterSearchDetailsAchievementView(achievements: achievements)
                }
            }
        }
    }
    
    private var accountInformationView: some View {
        Group {
            if let accountInformation = viewModel.model.accountInformation,
                let loyaltyTitle = accountInformation.loyaltyTitle, !loyaltyTitle.isEmpty,
                let created = accountInformation.created, !created.isEmpty {
                    Section("Account Information") {
                        CharacterSearchDetailsViewRow(title: "Loyalty Title", value: loyaltyTitle)
                        CharacterSearchDetailsViewRow(title: "Created", value: created.formatDate(with: .yyyyMMddTHHmmssZ))
                    }
            }
        }
    }
    
    private var otherCharactersView: some View {
        Group {
            if let otherCharacters = viewModel.model.otherCharacters {
                Section("Characters") {
                    CharacterSearchDetailsOtherCharactersView(characters: otherCharacters)
                }
            }
        }
    }
    
}

// MARK: - Actions
extension CharacterSearchDetailsView {
    
    private func save() {
        guard var characters = DefaultStorage.shared.retrieveArray(key: .character) else {
            let charArr: [String] = [viewModel.model.character.name ?? ""]
            DefaultStorage.shared.save(key: .character, value: charArr)
            
            if viewModel.isFromWorlds {
                self.navigationPath.removeLast()
            } else {
                self.navigationPath.removeLast(self.navigationPath.count)
            }
            
            return
        }
        
        characters.append(viewModel.model.character.name ?? "")
        DefaultStorage.shared.save(key: .character, value: characters)
        
        if viewModel.isFromWorlds {
            self.navigationPath.removeLast()
        } else {
            self.navigationPath.removeLast(self.navigationPath.count)
        }
        
        /* TODO: Thought:
         create function to handle the routing, if coming from worlds
         set the tab bar selected index to the characters tab index and
         show the list of characters
         
         but for now let's let as it is
         I'm sleepy 💤
         */
    }
    
}

#Preview {
    CharacterSearchDetailsView(navigationPath: Binding.constant(NavigationPath()),
                               viewModel: CharacterSearchDetailsViewModel(model: 
                                                CharacterModel(character:
                                                                CharacterInfoModel(accountStatus: nil,
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
                                                                    accountInformation: AccountInformationModel(created: "2005-10-29T09:44:10Z",
                                                                                                                loyaltyTitle: "Sage of Tibia",
                                                                                                                position: nil),
                                                                    achievements: [AchievementsModel(grade: 2, name: "Alumni", secret: false),
                                                                                   AchievementsModel(grade: 3, name: "Dread Lord", secret: true),
                                                                                   AchievementsModel(grade: 3, name: "Herbicide", secret: true),
                                                                                   AchievementsModel(grade: 3, name: "Unleash the Beast", secret: false),
                                                                                   AchievementsModel(grade: 3, name: "You Got Horse Power", secret: false)],
                                                                    otherCharacters: [OtherCharactersModel(deleted: nil,
                                                                                                           main: true,
                                                                                                           name: "Otavio Invencivel",
                                                                                                           position: nil,
                                                                                                           status: "online",
                                                                                                           traded: nil,
                                                                                                           world: "Inabra"),
                                                                                      OtherCharactersModel(deleted: nil,
                                                                                                           main: false,
                                                                                                           name: "Otavio On Inabra",
                                                                                                           position: nil,
                                                                                                           status: "offline",
                                                                                                           traded: nil,
                                                                                                           world: "Inabra"),
                                                                                      OtherCharactersModel(deleted: nil,
                                                                                                           main: false,
                                                                                                           name: "Zjow Vice",
                                                                                                           position: nil,
                                                                                                           status: "offline",
                                                                                                           traded: nil,
                                                                                                           world: "Quelibra")])))
}
