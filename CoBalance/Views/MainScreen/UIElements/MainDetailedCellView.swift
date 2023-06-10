//
//  MainDetailedCellView.swift
//  CoBalance
//
//  Created by Максим Боталов on 02.05.2023.
//

import SwiftUI

struct MainDetailedCellView: View {
    
    // MARK: - СВОЙСТВА
    // Входные параметры
    let currentOperation: OperationModel
    @Binding var showOperation: Bool
    
    // Объекты среды окружения
    @EnvironmentObject private var mainVM: MainViewModel
    
    // MARK: - ТЕЛО
    var body: some View {
        // Основное полотно
        VStack(alignment: .trailing, spacing: 16) {
            // Описание операции
            DescriptionOperationView(operation: currentOperation, isDetailedView: true)
            
            // Кнопки
            HStack(alignment: .center, spacing: 8) {
                // Удаление
                RoundButtonView(icon: "trash", isActive: true) {
                    showOperation = false
                    mainVM.deleteOperation(for: currentOperation)
                }
                
                // Закрытие
                RoundButtonView(icon: "xmark", isActive: true) {
                    showOperation = false
                }
            }
        }
        .padding(16)
        .background(Color.theme.backgroundPrimary)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .theme.backgroundSecondary, radius: 20, x: 0, y: -30)
    }
}

// MARK: - ПРЕДВАРИТЕЛЬНЫЙ ПРОСМОТР
struct MainDetailedView_Previews: PreviewProvider {
    static var previews: some View {
        MainDetailedCellView(currentOperation: DevelopmentPreview.instance.operation, showOperation: .constant(false))
            .environmentObject(DevelopmentPreview.instance.mainVM)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
