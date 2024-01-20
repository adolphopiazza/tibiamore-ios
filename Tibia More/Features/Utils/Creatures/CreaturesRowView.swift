//
//  CreaturesRowView.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 15/01/24.
//

import SwiftUI

struct CreaturesRowView: View {
    
    var creature: CreaturesDetailsModel
    
    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: creature.imageUrl)) { image in
                image
                    .resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50, height: 50, alignment: .center)
            
            Text(creature.name)
                .font(.title2)
                .fontDesign(.serif)
            
            Spacer()
            
            Image(systemName: .SFImages.chevronRight)
        }
    }
}

#Preview {
    CreaturesRowView(creature: CreaturesDetailsModel(featured: false, imageUrl: "", name: "Rotworm", race: "rotworm"))
}
