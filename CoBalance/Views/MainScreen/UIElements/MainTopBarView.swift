//
//  MainTopBarView.swift
//  CoBalance
//
//  Created by Максим Боталов on 02.05.2023.
//

import SwiftUI

struct MainTopBarView: View {
    
    // MARK: - СВОЙСТВА
    // Входные параметры
    @Binding var showSettings: Bool
    @Binding var newOperation: Bool
    
    // Объекты среды окружения
    @StateObject private var mainTopBarVM = MainTopBarViewModel()
    
    // MARK: - ТЕЛО
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            // Дата
            VStack(alignment: .leading, spacing: 0) {
                Text(mainTopBarVM.currentDay.capitalized)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(Color.theme.textPrimary)
                Text(mainTopBarVM.currentFullDate)
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                    .foregroundColor(Color.theme.textSecondary)
            }
            
            Spacer()
            
            // Аватарка + кнопка перехода к настройкам
            Image("Avatar")
                .resizable()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                .onTapGesture { showSettings = true }
            
            // Кнопка перехода к экрану новой операции
            RoundButtonView(icon: "plus", isActive: true) {
                newOperation = true
            }
        }
    }
}

// MARK: - ПРЕДВАРИТЕЛЬНЫЙ ПРОСМОТР
struct MainTopBarView_Previews: PreviewProvider {
    static var previews: some View {
        MainTopBarView(showSettings: .constant(false), newOperation: .constant(false))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
