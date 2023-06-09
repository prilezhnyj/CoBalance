//
//  PopupSuccessfullyView.swift
//  CoBalance
//
//  Created by Максим Боталов on 02.06.2023.
//

import SwiftUI

struct PopupSuccessfullyView: View {
    
    // MARK: - СВОЙСТВА
    // Входные параметры
    @Binding var isSuccessfully: Bool
    
    // MARK: - ТЕЛО
    var body: some View {
        Text("Successfully")
            .font(.system(size: 12, weight: .bold, design: .rounded))
            .foregroundColor(Color.theme.buttonText)
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(Color.theme.income)
            .clipShape(Capsule(style: .continuous))
            .offset(y: isSuccessfully ? 0 : 200)
            .padding(.bottom, 16)
            .transition(.move(edge: .bottom))
    }
}

// MARK: - ПРЕДВАРИТЕЛЬНЫЙ ПРОСМОТР
struct PopupSuccessfully_Previews: PreviewProvider {
    static var previews: some View {
        PopupSuccessfullyView(isSuccessfully: .constant(true))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
