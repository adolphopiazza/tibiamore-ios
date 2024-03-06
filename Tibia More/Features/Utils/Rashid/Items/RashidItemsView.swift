//
//  RashidItemsView.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 19/02/24.
//

import SwiftUI

struct RashidItemsView: View {
    
    @State private var searchItem: String = ""
    
    let rashidItems: [RashidModel]
    
    private var filteredItems: [RashidModel] {
        if searchItem.isEmpty {
            return rashidItems
        }
        
        return rashidItems.filter({ $0.item.lowercased().contains(searchItem.lowercased()) })
    }
    
    var body: some View {
        List(filteredItems, id: \.item) { item in
            VStack {
                LabeledContent("Item", value: item.item)
                LabeledContent("Value", value: item.value)
            }
        }
        .fontDesign(.serif)
        .navigationTitle("Rashid Items")
        .searchable(text: $searchItem)
    }
}

#Preview {
    NavigationStack {
        RashidItemsView(rashidItems: [RashidModel(item: "Item 1", value: "20000"),
                                      RashidModel(item: "Item 2", value: "150")])
    }
}
