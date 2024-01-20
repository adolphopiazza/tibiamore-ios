//
//  CreaturesDetailAboutView.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 19/01/24.
//

import SwiftUI

struct CreaturesDetailAboutView: View {
    
    var creature: SpecificCreatureInfoModel?
    
    var body: some View {
        Section("About") {
            // Let's use worlds details view row but to-do: create a more generic
            // view to use across the app
            WorldsDetailsViewRow("Behaviour", value: creature?.behaviour, orientation: .vertical)
            WorldsDetailsViewRow("Hitpoints", value: creature?.hitpoints)
            WorldsDetailsViewRow("Loot List", value: creature?.lootList?.joined(separator: ", "), orientation: creature?.lootList?.count == 1 ? .horizontal : .vertical)
            WorldsDetailsViewRow("Experience Points", value: creature?.experiencePoints)
            WorldsDetailsViewRow("Immune to", value: creature?.immune?.joined(separator: ", "))
            WorldsDetailsViewRow("Strong against", value: creature?.strong?.joined(separator: ", "))
            WorldsDetailsViewRow("Weakness for", value: creature?.weakness?.joined(separator: ", "))
            
            if let seeInvisible = creature?.seeInvisible {
                WorldsDetailsViewRow("See invisible", value: seeInvisible ? "✅" : "🚫")
            }
            
            if let beParalysed = creature?.beParalysed {
                WorldsDetailsViewRow("Can be Paralysed", value: beParalysed ? "✅" : "🚫")
            }
            
            if let beSummoned = creature?.beSummoned, beSummoned {
                DisclosureGroup("Summon with") {
                    Text("\(String(creature?.summonedMana ?? 0)) points of mana")
                }
            }
            
            if let beConvinced = creature?.beConvinced, beConvinced {
                DisclosureGroup("Convince with") {
                    Text("\(String(creature?.convincedMana ?? 0)) points of mana")
                }
            }
        }
    }
}

#Preview {
    CreaturesDetailAboutView()
}
