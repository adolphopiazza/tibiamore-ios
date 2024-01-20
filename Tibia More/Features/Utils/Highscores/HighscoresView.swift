//
//  HighscoresView.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 20/01/24.
//

import SwiftUI

struct HighscoresView: View {
    
    var body: some View {
        Text("Hello, Highscores")
            .task {
                do {
                    let result = try await UtilsService.shared.fetchHighscores(vocation: .druids)
                    print(result)
                } catch {
                    print(error)
                }
            }
    }
    
}

#Preview {
    HighscoresView()
}
