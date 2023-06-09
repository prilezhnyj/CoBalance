//
//  CategoryIcon.swift
//  CoBalance
//
//  Created by Максим Боталов on 25.05.2023.
//

import SwiftUI

struct CategoryIconView: View {
    
    // MARK: - СВОЙСТВА
    // Входные параметры
    var icon: String
    
    // MARK: - ТЕЛО
    var body: some View {
        Text(icon)
            .font(.system(size: 16, weight: .bold, design: .rounded))
            .frame(width: 34, height: 34, alignment: .center)
            .background(Color.theme.backgroundSecondary)
            .clipShape(Circle())
    }
}

// MARK: - ПРЕДВАРИТЕЛЬНЫЙ ПРОСМОТР
struct CategoryIcon_Previews: PreviewProvider {
    static var previews: some View {
        CategoryIconView(icon: "😀")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
