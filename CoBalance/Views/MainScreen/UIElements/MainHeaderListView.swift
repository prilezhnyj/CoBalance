//
//  HeaderListView.swift
//  CoBalance
//
//  Created by Максим Боталов on 02.05.2023.
//

import SwiftUI

struct MainHeaderListView: View {
    
    // MARK: - СВОЙСТВА
    // Входные параметры
    var header: String
    var operations: [Operation]
    
    // MARK: - ТЕЛО
    var body: some View {
        if !operations.isEmpty {
            HStack(alignment: .center, spacing: 16) {
                // Заголовок
                Text(header.uppercased())
                
                Spacer()
                
                // Сумма всех операций
                Text(operations.reduce(0, { $0 + $1.amount }).currentFormatter)
            }
            .font(.system(size: 14, weight: .bold, design: .rounded))
            .foregroundColor(Color.theme.textSecondary)
            .padding(.trailing, 16)
        }
    }
}

// MARK: - ПРЕДВАРИТЕЛЬНЫЙ ПРОСМОТР
struct HeaderListView_Previews: PreviewProvider {
    static var previews: some View {
        MainHeaderListView(header: "Header", operations: [DevelopmentPreview.instance.operation])
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
