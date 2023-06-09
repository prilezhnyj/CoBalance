//
//  Warning.swift
//  CoBalance
//
//  Created by Максим Боталов on 25.05.2023.
//

import SwiftUI

struct PopupWarningView: View {
    
    // MARK: - СВОЙСТВА
    // Входные параметры
    @Binding var text: String
    
    // MARK: - Тело
    var body: some View {
        Text(text)
            .font(.system(size: 14, weight: .regular, design: .rounded))
            .multilineTextAlignment(.leading)
            .foregroundColor(Color.theme.expense)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - ПРЕДВАРИТЕЛЬНЫЙ ПРОСМОТР
struct PopupWarning_Previews: PreviewProvider {
    static var previews: some View {
        PopupWarningView(text: .constant("Lorem ipsum dolor sit amet, consectetuer adipiscing."))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
