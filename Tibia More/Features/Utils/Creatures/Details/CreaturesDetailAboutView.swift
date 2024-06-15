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
            WorldsDetailsViewRow("Creature.Behaviour", value: creature?.behaviour, orientation: .vertical)
            WorldsDetailsViewRow("Creature.Hitpoints", value: creature?.hitpoints)
            WorldsDetailsViewRow("Creature.LootList", value: creature?.lootList?.joined(separator: ", "), orientation: creature?.lootList?.count == 1 ? .horizontal : .vertical)
            WorldsDetailsViewRow("Creature.XP", value: creature?.experiencePoints)
            WorldsDetailsViewRow("Creature.Immune", value: creature?.immune?.joined(separator: ", "))
            WorldsDetailsViewRow("Creature.Strong", value: creature?.strong?.joined(separator: ", "))
            WorldsDetailsViewRow("Creature.Weak", value: creature?.weakness?.joined(separator: ", "))
            
            if let seeInvisible = creature?.seeInvisible {
                WorldsDetailsViewRow("Creature.Invisible", value: seeInvisible ? "✅" : "🚫")
            }
            
            if let beParalysed = creature?.beParalysed {
                WorldsDetailsViewRow("Creature.Paralysed", value: beParalysed ? "✅" : "🚫")
            }
            
            if let beSummoned = creature?.beSummoned, beSummoned {
                DisclosureGroup("Creature.Summon") {
                    Text("\(String(creature?.summonedMana ?? 0)) points of mana")
                }
            }
            
            if let beConvinced = creature?.beConvinced, beConvinced {
                DisclosureGroup("Creature.Convince") {
                    Text("\(String(creature?.convincedMana ?? 0)) points of mana")
                }
            }
        }
    }
}

#Preview {
    CreaturesDetailAboutView()
}
