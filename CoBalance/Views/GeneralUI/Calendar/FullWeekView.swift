//
//  FullWeek.swift
//  CoBalance
//
//  Created by Максим Боталов on 29.05.2023.
//

import SwiftUI

struct FullWeekView: View {
    
    // MARK: - СВОЙСТВА
    // Объекты среды окружения
    @StateObject private var calendarVM = CalendarViewModel()
    @EnvironmentObject private var mainVM: MainViewModel
    
    // MARK: - ТЕЛО
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            // Неделя
            ForEach(calendarVM.currentWeek, id: \.self) { day in
                OneDayView(day: day, isToday: calendarVM.isToday(for: day), isEmptyOperation: mainVM.checkOperationInSelectedDay(for: day))
            }
            .onChange(of: mainVM.selectedDayWeek) { newValue in
                // Изменение списка операции под выбранный день
                mainVM.filteringOperations()
            }
        }
    }
}

// MARK: - ПРЕДВАРИТЕЛЬНЫЙ ПРОСМОТР
struct FullWeek_Previews: PreviewProvider {
    static var previews: some View {
        FullWeekView()
            .environmentObject(DevelopmentPreview.instance.mainVM)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
