//
//  NumpadRowView.swift
//  CoBalance
//
//  Created by Максим Боталов on 03.05.2023.
//

import SwiftUI

struct NumpadRowView: View {
    
    // MARK: - СВОЙСТВА
    // Входные параметры
    var numbers: [String]
    
    // MARK: - ТЕЛО
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            ForEach(numbers, id: \.self) { button in
                NumpadButtonView(number: button)
            }
        }
    }
}

// MARK: - ПРЕДВАРИТЕЛЬНЫЙ ПРОСМОТР
struct NumpadRow_Previews: PreviewProvider {
    static var previews: some View {
        NumpadRowView(numbers: ["1", "2", "3"])
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
