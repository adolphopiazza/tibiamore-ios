//
//  UtilsListRowView.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 14/01/24.
//

import SwiftUI

struct UtilsListRowView: View {
    
    var menuItem: UtilsListViewModel.Utils
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(menuItem.title.localized)
                    .font(.title)
                
                Text(menuItem.description.localized)
                    .font(.footnote)
            }
            
            Spacer()
            
            Image(systemName: .SFImages.chevronRight)
        }
        .fontDesign(.serif)
    }
}

#Preview {
    UtilsListRowView(menuItem: .fansites)
}
