//
//  BrowserView.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 14/12/23.
//

import SwiftUI

struct BrowserView: View {
    
    @Binding var navigationPath: NavigationPath
    var url: String
    
    var body: some View {
        SafariView(url: URL(string: url) ?? .tibiaURL)
            .navigationBarTitleDisplayMode(.inline)
            .ignoresSafeArea(edges: .bottom)
            .toolbar(.hidden, for: .tabBar)
    }
    
}

#Preview {
    BrowserView(navigationPath: Binding.constant(NavigationPath()), url: URL.tibiaURL.absoluteString)
}
