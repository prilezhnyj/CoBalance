//
//  CalendarViewModel.swift
//  CoBalance
//
//  Created by Максим Боталов on 29.05.2023.
//

import Foundation
import Combine

class CalendarViewModel: ObservableObject {
    
    // MARK: - СВОЙСТВА
    // ПУБЛИЧНЫЕ СВОЙСТВА
    @Published var currentShortDate = ""
    @Published var currentShortDay = ""
    @Published var currentWeek = [Date]()
    @Published var selectedDayWeek = Date()
    
    // ПРИВАТНЫЕ СВОЙСТВА
    private var subscribers = Set<AnyCancellable>()
    private let dateService = DateService.instance
    private let dataService = DataService.instance
    
    init() {
        addSubscribers()
    }
    
    // MARK: - МЕТОДЫ И ФУНКЦИИ
    // ДОБАВЛЕНИЕ ПОДПИСЧИКОВ COMBINE
    private func addSubscribers() {
        dateService.$currentDay
            .sink { [weak self] currentShortDateDateService in
                self?.currentShortDate = currentShortDateDateService
            }
            .store(in: &subscribers)
        
        dateService.$currentFullDate
            .sink { [weak self] currentShortDayDateService in
                self?.currentShortDay = currentShortDayDateService
            }
            .store(in: &subscribers)
        
        dateService.$currentWeek
            .sink { [weak self] currentWeekDateService in
                self?.currentWeek = currentWeekDateService
            }
            .store(in: &subscribers)
    }
    
    func isToday(for date: Date) -> Bool {
        return dateService.currentCalendar.isDate(.now, inSameDayAs: date)
    }
}
