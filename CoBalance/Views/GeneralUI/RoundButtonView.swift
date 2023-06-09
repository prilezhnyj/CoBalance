//
//  RoundButton.swift
//  CoBalance
//
//  Created by Максим Боталов on 09.05.2023.
//

import SwiftUI

struct RoundButtonView: View {
    
    // MARK: - СВОЙСТВА
    // Входные параметры
    var icon: String
    var isActive: Bool
    var action: () -> Void
    
    //MARK: - ТЕЛО
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: icon)
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .frame(width: 40, height: 40, alignment: .center)
                .foregroundColor(Color.theme.buttonText)
                .background(Color.theme.buttonBackground)
                .clipShape(Capsule(style: .continuous))
                .opacity(isActive ? 1 : 0.4)
                .shadow(color: isActive ? Color.theme.buttonBackground.opacity(0.3) : .clear, radius: 8, x: 0, y: 8)
        }
    }
}

// MARK: - ПРЕДВАРИТЕЛЬНЫЙ ПРОСМОТР
struct RoundButton_Previews: PreviewProvider {
    static var previews: some View {
        RoundButtonView(icon: "xmark", isActive: true, action: {})
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
