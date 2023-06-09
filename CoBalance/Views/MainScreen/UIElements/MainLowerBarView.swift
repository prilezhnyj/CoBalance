//
//  MainLowerBar.swift
//  CoBalance
//
//  Created by Максим Боталов on 02.05.2023.
//

import SwiftUI

struct MainLowerBarView: View {
    
    // MARK: - СВОЙСТВА
    // Входные параметры
    @Binding var newOperation: Bool
    
    // MARK: - ТЕЛО
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            PrimaryButtonView(title: "New operation", isActive: true) {
                newOperation = true
            }
        }
    }
}

// MARK: - ПРЕДВАРИТЕЛЬНЫЙ ПРОСМОТР
struct MainLowerBar_Previews: PreviewProvider {
    static var previews: some View {
        MainLowerBarView(newOperation: .constant(false))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
