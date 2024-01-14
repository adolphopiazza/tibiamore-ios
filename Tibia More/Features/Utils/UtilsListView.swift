//
//  UtilsListView.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 13/01/24.
//

import SwiftUI

struct UtilsListView: View {
    
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
        Text("Hello, Utils!")
    }
}

#Preview {
    UtilsListView(navigationPath: Binding.constant(NavigationPath()))
}
