//
//  MainWidget.swift
//  CoBalance
//
//  Created by Максим Боталов on 27.05.2023.
//

import SwiftUI

struct MainInfoWidgetView: View {
    
    // MARK: - СВОЙСТВА
    // Входные параметры
    var action: () -> Void
    
    // Объекты среды окружения
    @StateObject private var mainInfoWidgetVM = MainInfoWidgetViewModel()
    
    // MARK: - ТЕЛО
    var body: some View {
        allView()
    }
    
    // MARK: - ФУНКЦИИ && UI
    // Информация слева
    private func informationLeft() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            // Месяц
            VStack(alignment: .leading, spacing: 0) {
                Text("In \(mainInfoWidgetVM.currentMonth.capitalized)")
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundColor(Color.theme.textPrimary)
                
                Text("you saved")
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                    .foregroundColor(Color.theme.textSecondary)
            }
            
            // Сумма
            Text(mainInfoWidgetVM.getDifferenceAmounts().currentFormatter)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(Color.theme.textPrimary)
        }
    }
    
    // Информация справа
    private func informationRight() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            // Заработали
            VStack(alignment: .leading, spacing: 0) {
                Text("earned")
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                    .foregroundColor(Color.theme.textSecondary)
                
                // Иконка + сумма
                HStack {
                    Capsule(style: .continuous)
                        .frame(width: 5, height: 16, alignment: .center)
                        .foregroundColor(Color.theme.income)
                    
                    Text(mainInfoWidgetVM.getAmount(for: .income).currentFormatter)
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundColor(Color.theme.textPrimary)
                }
            }
            
            // Потратили
            VStack(alignment: .leading, spacing: 0) {
                Text("spent")
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                    .foregroundColor(Color.theme.textSecondary)
                
                HStack {
                    Capsule(style: .continuous)
                        .frame(width: 5, height: 16, alignment: .center)
                        .foregroundColor(Color.theme.expense)
                    
                    Text(mainInfoWidgetVM.getAmount(for: .expense).currentFormatter)
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundColor(Color.theme.textPrimary)
                }
            }
        }
    }
    
    // Информация объединенная
    private func allView() -> some View {
        VStack(spacing: 16) {
            HStack(alignment: .top) {
                informationLeft()
                Spacer()
                informationRight()
            }
            
            // ПрогрессБар с процентами
            Capsule(style: .continuous)
                .frame(maxWidth: .infinity)
                .frame(height: 16)
        }
        .padding(16)
        .background(Color.theme.backgroundPrimary)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.theme.backgroundSecondary, radius: 8, x: 0, y: 8)
        .onTapGesture {
            action()
        }
    }
}

// MARK: - ПРЕДВАРИТЕЛЬНЫЙ ПРОСМОТР
struct IMainInfoWidget_Previews: PreviewProvider {
    static var previews: some View {
        MainInfoWidgetView(action: {})
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
