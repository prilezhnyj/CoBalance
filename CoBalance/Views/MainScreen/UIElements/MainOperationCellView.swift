//
//  OperationCellListView.swift
//  CoBalance
//
//  Created by Максим Боталов on 02.05.2023.
//

import SwiftUI

struct MainOperationCellView: View {
    
    // MARK: - СВОЙСТВА
    // Входные параметры
    var operation: Operation
    
    // MARK: - Тело
    var body: some View {
        DescriptionOperationView(operation: operation, isDetailedView: false)
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(Color.theme.backgroundPrimary)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .shadow(color: Color.theme.backgroundSecondary, radius: 3, x: 0, y: 1)
    }
}

// MARK: - ПРЕДВАРИТЕЛЬНЫЙ ПРОСМОТР
struct OperationCellListView_Previews: PreviewProvider {
    static var previews: some View {
        MainOperationCellView(operation: DevelopmentPreview.instance.operation)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
