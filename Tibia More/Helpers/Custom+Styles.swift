//
//  Custom+Styles.swift
//  Tibia More
//
//  Created by Adolpho Francisco Zimmermann Piazza on 17/12/23.
//

import SwiftUI

// MARK: - TextField styles
struct CharacterSearchTextFieldStyle: TextFieldStyle {

    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(16)
            .background {
                Color(uiColor: .systemGray6)
            }
            .clipShape(.rect(cornerRadius: 8))
            .multilineTextAlignment(.center)
            .font(.title3)
            .fontDesign(.serif)
    }
    
}

// MARK: - Button styles
struct TibiaMorePrimaryButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background {
                Color.accentColor
            }
            .font(.title2)
            .fontDesign(.serif)
            .foregroundStyle(.background)
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    
}

#Preview {
    VStack(spacing: 20) {
        TextField("Insert your character name", text: Binding.constant(""))
            .textFieldStyle(CharacterSearchTextFieldStyle())
            .padding()
        
        Button("Touch here", action: {})
            .buttonStyle(TibiaMorePrimaryButtonStyle())
            .padding()
    }
}
