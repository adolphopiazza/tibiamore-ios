//
//  WikiView.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 19/02/24.
//

import SwiftUI

struct WikiView: View {
    
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            Text("Wiki!")
        }
    }
}

#Preview {
    WikiView(navigationPath: Binding.constant(NavigationPath()))
}
