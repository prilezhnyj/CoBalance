//
//  NumpadButton.swift
//  CoBalance
//
//  Created by Максим Боталов on 03.05.2023.
//

import SwiftUI

struct NumpadButtonView: View {
    
    // MARK: - СВОЙСТВА
    // Входные параметры
    var number: String
    
    // Объекты среды окружения
    @Environment(\.keyPadButtonAction) var action: (String) -> Void
    
    // MARK: - ТЕЛО
    var body: some View {
        Button(action: { self.action(self.number) }) {
            Text(number)
                .foregroundColor(Color.theme.textPrimary)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .frame(height: 40)
                .frame(maxWidth: .infinity)
                .overlay {
                    Capsule(style: .continuous)
                        .stroke(lineWidth: 1)
                        .foregroundColor(Color.theme.backgroundSecondary)
                }
        }
    }
    
    enum ActionKey: EnvironmentKey {
        static var defaultValue: (String) -> Void { { _ in } }
    }
}

// MARK: - РАСШИРЕНИЕ
extension EnvironmentValues {
    var keyPadButtonAction: (String) -> Void {
        get { self[NumpadButtonView.ActionKey.self] }
        set { self[NumpadButtonView.ActionKey.self] = newValue }
    }
}

// MARK: - ПРЕДВАРИТЕЛЬНЫЙ ПРОСМОТР
struct NumpadButton_Previews: PreviewProvider {
    static var previews: some View {
        NumpadButtonView(number: "9")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
