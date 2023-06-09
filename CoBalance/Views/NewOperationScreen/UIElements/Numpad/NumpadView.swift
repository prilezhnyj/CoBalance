//
//  Numpad.swift
//  CoBalance
//
//  Created by Максим Боталов on 03.05.2023.
//

import SwiftUI

struct NumpadView: View {
    
    // MARK: - СВОЙСТВА
    // Входные параметры
    @Binding var amount: String
    @Binding var closeNumpad: Bool
    
    // MARK: - ТЕЛО
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            NumpadRowView(numbers: ["1", "2", "3"])
            NumpadRowView(numbers: ["4", "5", "6"])
            NumpadRowView(numbers: ["7", "8", "9"])
            NumpadRowView(numbers: [".", "0", "⌫"])
            
            // Кнопка закрытия
            Button {
                closeNumpad = false
            } label: {
                Text("Close numpad".uppercased())
                    .font(.system(size: 12, weight: .bold, design: .rounded))
                    .foregroundColor(Color.theme.expense)
                    .padding(.top)
            }
        }
        .environment(\.keyPadButtonAction, self.keyWasPressed(_:))
        .padding()
        .background(Color.theme.backgroundPrimary)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .theme.backgroundSecondary, radius: 20, x: 0, y: -30)
    }
    
    // MARK: - ФУНКЦИИ && UI
    private func keyWasPressed(_ key: String) {
        switch key {
        case "." where amount.contains("."): break
        case "." where amount == "0": amount += key
        case "⌫":
            if amount != "" { amount.removeLast() }
            if amount.isEmpty { amount = "" }
        case _ where amount == "": amount = key
        default: amount += key
        }
    }
}

// MARK: - ПРЕДВАРИТЕЛЬНЫЙ ПРОСМОТР
struct Numpad_Previews: PreviewProvider {
    static var previews: some View {
        NumpadView(amount: .constant("Amount"), closeNumpad: .constant(false))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
