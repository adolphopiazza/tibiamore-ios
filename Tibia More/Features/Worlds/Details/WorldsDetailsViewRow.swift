//
//  WorldsDetailsViewRow.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 12/01/24.
//

import SwiftUI

struct WorldsDetailsViewRow: View {
    
    let title: String
    let value: String?
    let orientation: Axis
    
    init(_ title: String, value: String?, orientation: Axis = .horizontal) {
        self.title = title
        self.value = value
        self.orientation = orientation
    }
    
    init(_ title: String, value: Int?, orientation: Axis = .horizontal) {
        self.title = title
        self.orientation = orientation
        
        if let value {
            self.value = String(value)
        } else {
            self.value = nil
        }
    }
    
    var body: some View {
        if let value = value, !value.isEmpty {
            if orientation == .horizontal {
                LabeledContent(title.localized, value: value)
            } else {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title.localized)
                    
                    Text(value)
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
}

#Preview {
    WorldsDetailsViewRow("PvP Type", value: 3)
}
