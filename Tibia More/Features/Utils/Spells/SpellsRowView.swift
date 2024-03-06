//
//  SpellsRowView.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 19/02/24.
//

import SwiftUI

struct SpellsRowView: View {
    
    let spell: SpellsModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(spell.name)
                    .font(.title2)
                
                Spacer()
                
                AsyncImage(url: URL(string: spell.imageUrl)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .frame(width: 35, height: 35)
                    } else if phase.error != nil {
                        Image(systemName: .SFImages.wand)
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundStyle(.accent)
                    } else {
                        ProgressView()
                    }
                }
            }
            
            LabeledContent("Vocation") {
                Text(spell.spellInformation.vocation.joined(separator: ", "))
                    .multilineTextAlignment(.trailing)
            }
            .padding(.top, 12)
            
            LabeledContent("Level", value: String(spell.spellInformation.level))
            LabeledContent("Formula", value: spell.spellInformation.formula)
            LabeledContent("Price", value: "\(String(spell.spellInformation.price)) gp")
            LabeledContent("Premium", value: spell.spellInformation.premiumOnly ? "✅" : "🚫")
        }
    }
}

#Preview {
    SpellsRowView(spell: SpellsModel(name: "Strong Haste",
                                     imageUrl: "nil",
                                     spellInformation: SpellInformationModel(vocation: ["Druid", "Sorcerer"],
                                                                             level: 20,
                                                                             premiumOnly: true,
                                                                             formula: "utani gran hur", 
                                                                             price: 1000),
                                     spellId: "stronghaste"))
}
