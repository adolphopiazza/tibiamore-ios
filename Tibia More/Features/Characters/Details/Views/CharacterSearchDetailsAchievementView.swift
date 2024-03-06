//
//  CharacterSearchDetailsAchievementView.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 22/12/23.
//

import SwiftUI

struct CharacterSearchDetailsAchievementView: View {
    
    let achievements: [AchievementsModel]
    
    var body: some View {
        ForEach(achievements, id: \.name) { achievement in
            if let grade = achievement.grade, let name = achievement.name, let secret = achievement.secret {
                VStack(alignment: .leading) {
                    HStack {
                        Text(name)
                        
                        Spacer()
                        
                        if secret {
                            Image(.achievementSecret)
                        }
                    }
                    
                    HStack {
                        ForEach(0 ..< grade, id: \.self) { _ in
                            Image(.achievement)
                        }
                    }
                }
                .fontDesign(.serif)
            }
        }
    }
    
}

#Preview {
    CharacterSearchDetailsAchievementView(achievements: [AchievementsModel(grade: 3, name: "Alumni", secret: false)])
}
