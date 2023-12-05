//
//  NewsListView.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 04/12/23.
//

import SwiftUI

struct NewsListView: View {
    
    var body: some View {
        Text("Here we'll have a list with Tibia news")
    }
    
}

#Preview("Light Mode") {
    NewsListView()
        .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    NewsListView()
        .preferredColorScheme(.dark)
}

#Preview("News on tab bar", body: {
    TabBarView()
})
