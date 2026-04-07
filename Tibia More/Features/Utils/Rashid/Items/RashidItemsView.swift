//
//  RashidItemsView.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 19/02/24.
//

import SwiftUI

struct RashidItemsView: View {
    
    @State private var searchItem: String = ""
    @State private var rashidItems: [RashidModel] = []
    
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
        .navigationTitle("Rashid.Items.Desc")
        .searchable(text: $searchItem)
        .task {
            do {
                let items = try await UtilsService.shared.fetchRashidItems()
                rashidItems = items
            } catch {
                print("Some error on RashidItemsView: \(error)")
            }
        }
    }
}

#Preview {
    NavigationStack {
        RashidItemsView()
    }
}
