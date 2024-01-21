//
//  FansiteRowView.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 20/01/24.
//

import SwiftUI

struct FansiteRowView: View {
    
    let model: FansiteModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: URL(string: model.logoUrl)) { image in
                    image
                } placeholder: {
                    ProgressView()
                }
                
                Text(model.name)
                    .font(.title3)
            }
            
            Spacer()
            
            Image(systemName: .SFImages.chevronRight)
        }
    }
    
}

#Preview {
    FansiteRowView(model: FansiteModel(contact: "",
                                       contentType: FansiteContentModel(statistics: false, 
                                                                        texts: false,
                                                                        tools: false,
                                                                        wiki: false),
                                       fansiteItem: false,
                                       fansiteItemUrl: "",
                                       homepage: "",
                                       languages: [],
                                       logoUrl: "",
                                       name: "",
                                       socialMedia: FansiteSocialModel(discord: false, 
                                                                       facebook: false,
                                                                       instagram: false,
                                                                       reddit: false,
                                                                       twitch: false,
                                                                       twitter: false,
                                                                       youtube: false),
                                       specials: []))
}
