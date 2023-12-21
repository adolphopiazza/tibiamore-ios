//
//  CharacterSearchDetailsViewRow.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 21/12/23.
//

import SwiftUI

struct CharacterSearchDetailsViewRow: View {
    
    var title: String
    var value: String
    var orientation: Axis = .horizontal
    
    var body: some View {
        if orientation == .horizontal {
            HStack {
                Text(self.title)
                
                Spacer()
                
                Text(self.value)
                    .foregroundStyle(.secondary)
            }
            .fontDesign(.serif)
        } else {
            VStack(alignment: .leading) {
                Text(self.title)
                
                Text(self.value)
                    .foregroundStyle(.secondary)
            }
            .fontDesign(.serif)
        }
    }
    
}

#Preview {
    CharacterSearchDetailsViewRow(title: "Name", value: "Hirk", orientation: .vertical)
}
