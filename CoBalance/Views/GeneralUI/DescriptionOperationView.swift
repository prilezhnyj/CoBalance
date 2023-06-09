//
//  DescriptionOperationView.swift
//  CoBalance
//
//  Created by Максим Боталов on 26.05.2023.
//

import SwiftUI

struct DescriptionOperationView: View {
    
    // MARK: - СВОЙСТВА
    // Входные параметры
    var operation: Operation
    var isDetailedView: Bool
    
    // MARK: - ТЕЛО
    var body: some View {
        // Основное полотно
        VStack {
            // Иконка + категория + сумма
            HStack(alignment: .center, spacing: 16) {
                // Иконка категории операции
                CategoryIconView(icon: operation.category.logo)
                
                // Заголовок + описание (опционально)
                VStack(alignment: .leading, spacing: 0) {
                    Text(operation.category.title)
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundColor(Color.theme.textPrimary)
                    
                    // Проверка есть ли описание
                    if operation.description != "" {
                        Text(isDetailedView ? operation.category.type.rawValue : operation.description)
                            .font(.system(size: 14, weight: .regular, design: .rounded))
                            .lineLimit(1)
                            .foregroundColor(Color.theme.textSecondary)
                    }
                }
                
                Spacer()
                
                // Сумма
                Text(operation.amount.currentFormatter)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundColor(operation.category.type == .expense ? Color.theme.expense : Color.theme.income)
            }
            
            // Описание
            if isDetailedView {
                if operation.description != "" {
                    Text(operation.description)
                        .font(.system(size: 14, weight: .regular, design: .rounded))
                        .foregroundColor(Color.theme.textSecondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }
}

// MARK: - ПРЕДВАРИТЕЛЬНЫЙ ПРОСМОТР
struct DescriptionOperation_Previews: PreviewProvider {
    static var previews: some View {
        DescriptionOperationView(operation: DevelopmentPreview.instance.operation, isDetailedView: true)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
