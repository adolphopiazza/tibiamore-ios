//
//  FansitesView.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 20/01/24.
//

import SwiftUI

struct FansitesView: View {
    
    var body: some View {
        Text("Hello, Fansites!")
            .task {
                do {
                    let result = try await UtilsService.shared.fetchFansites()
                    print(result)
                } catch {
                    print("error")
                }
            }
    }
    
}

#Preview {
    FansitesView()
}
