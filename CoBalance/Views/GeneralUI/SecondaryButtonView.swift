//
//  SecondaryButton.swift
//  CoBalance
//
//  Created by Максим Боталов on 04.05.2023.
//

import SwiftUI

struct SecondaryButtonView: View {
    
    // MARK: - СВОЙСТВА
    // Входные параметры
    var icon: String?
    var title: String
    var isActive: Bool
    var action: () -> Void
    
    // MARK: - ТЕЛО
    var body: some View {
        Button {
            action()
        } label: {
            HStack(alignment: .center, spacing: 8) {
                // Иконка
                if icon != nil { Image(systemName: icon!) }
                
                // Заголовок
                Text(title.uppercased())
            }
            .font(.system(size: 14, weight: .bold, design: .rounded))
            .padding(.vertical, 8)
            .padding(.horizontal, 32)
            .foregroundColor(Color.theme.buttonText)
            .background(Color.theme.buttonBackground)
            .clipShape(Capsule(style: .continuous))
            .opacity(isActive ? 1 : 0.4)
            .shadow(color: isActive ? Color.theme.buttonBackground.opacity(0.3) : .clear, radius: 8, x: 0, y: 8)
        }
    }
}

// MARK: - ПРЕДВАРИТЕЛЬНЫЙ ПРОСМОТР
struct SecondaryButton_Previews: PreviewProvider {
    static var previews: some View {
        SecondaryButtonView(icon: "doc", title: "Save", isActive: true, action: {})
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
