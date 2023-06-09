//
//  OneDay.swift
//  CoBalance
//
//  Created by Максим Боталов on 29.05.2023.
//

import SwiftUI

struct OneDayView: View {
    
    // MARK: - СВОЙСТВА
    // Входные параметры
    let day: Date
    let isToday: Bool
    let isEmptyOperation: Bool
    
    // Объекты среды окружения
    @EnvironmentObject private var mainVM: MainViewModel
    
    // MARK: - ТЕЛО
    var body: some View {
        // Один день
        VStack(alignment: .center, spacing: 4) {
            // Число месяца
            Text(day.formatter(for: day, format: "EE"))
                .foregroundColor(isToday ? Color.theme.textSecondarySelected : Color.theme.textSecondary)
                .font(.system(size: 12, weight: .regular, design: .rounded))
            
            // Краткое название недели
            Text(day.formatter(for: day, format: "dd"))
                .foregroundColor(isToday ? Color.theme.textPrimarySelected : Color.theme.textPrimary)
                .font(.system(size: 16, weight: .bold, design: .rounded))
            
            // Индикатор, есть ли операции в текущем дне
            Circle()
                .frame(width: 8, height: 8, alignment: .center)
                .foregroundColor(isToday ? .theme.textPrimarySelected : .theme.textPrimary)
                .opacity(isEmptyOperation ? 0 : 1)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .background(isToday ? Color.theme.backgroundPrimarySelected : Color.theme.backgroundPrimary)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.theme.backgroundSecondary, radius: 3, x: 0, y: 1)
        .onTapGesture {
            withAnimation(.spring()) {
                mainVM.selectedDayWeek = day
            }
        }
        .overlay(alignment: .center) {
            // Обводка выбранного дня
            RoundedRectangle(cornerRadius: 20, style: .continuous).stroke(mainVM.selectedDayWeek == day ? Color.theme.textPrimary : Color.theme.backgroundPrimary , lineWidth: 2)
        }
    }
}

// MARK: - ПРЕДВАРИТЕЛЬНЫЙ ПРОСМОТР
struct OneDay_Previews: PreviewProvider {
    static var previews: some View {
        OneDayView(day: .now, isToday: true, isEmptyOperation: false)
            .environmentObject(DevelopmentPreview.instance.mainVM)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
