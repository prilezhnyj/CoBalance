//
//  CategoryCell.swift
//  CoBalance
//
//  Created by Максим Боталов on 09.05.2023.
//

import SwiftUI

struct CategoryCellView: View {
    
    // MARK: - СВОЙСТВА
    // Входные параметры
    var category: Category
    var action: () -> Void
    
    // Объекты среды окружения
    @EnvironmentObject var categoryViewModel: CategoryViewModel
    
    // MARK: - ТЕЛО
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            // Иконка
            CategoryIconView(icon: category.logo)
            
            // Заголовок
            Text(category.title)
                .foregroundColor(Color.theme.textPrimary)
            
            Spacer()
            
            // Кнопка удаления
            Button {
                withAnimation(.spring()) {
                    action()
                }
            } label: {
                Image(systemName: "trash")
                    .foregroundColor(Color.theme.expense)
            }
        }
        .font(.system(size: 16, weight: .bold, design: .rounded))
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        .background(Color.theme.backgroundPrimary)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .shadow(color: Color.theme.backgroundSecondary, radius: 3, x: 0, y: 1)
    }
}

// MARK: - ПРЕДВАРИТЕЛЬНЫЙ ПРОСМОТР
struct CategoryCell_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCellView(category: .init(type: .expense, title: "Продукты", logo: "🥕"), action: {})
            .environmentObject(DevelopmentPreview.instance.categoryVM)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

