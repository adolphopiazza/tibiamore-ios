//
//  CharacterSearchDetailsDeathsView.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 20/03/24.
//

import SwiftUI

struct CharacterSearchDetailsDeathsView: View {
    
    let deathsModel: [DeathsModel]
    
    var body: some View {
        ForEach(deathsModel, id: \.hashValue) { death in
            if let deathTime = death.time, let reason = death.reason {
                CharacterSearchDetailsViewRow(title: deathTime.formatDate(with: .yyyyMMddTHHmmssZ),
                                              value: reason,
                                              orientation: .vertical)
            }
        }
    }
    
}

#Preview {
    CharacterSearchDetailsDeathsView(deathsModel: [DeathsModel(level: 23,
                                                               reason: "Died at Level 23 by cyclops drone.",
                                                               time: "2024-03-19T21:39:46Z",
                                                               assists: nil,
                                                               killers: nil)])
}
