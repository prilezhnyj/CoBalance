//
//  DateService.swift
//  CoBalance
//
//  Created by Максим Боталов on 29.05.2023.
//

import Foundation
import Combine

class DateService {
    @Published var currentMonth = ""
    @Published var currentDay = ""
    @Published var currentFullDate = ""
    @Published var currentShortDate = ""
    @Published var currentShortDay = ""
    @Published var currentWeek = [Date]()
    
    static let instance = DateService()
    
    private let currentDate = Date()
    let currentCalendar = Calendar.current
    
    private init() {
        currentMonth = getCurrentDate(for: currentDate, format: "MMMM")
        currentDay = getCurrentDate(for: currentDate, format: "EEEE")
        currentFullDate = getCurrentDate(for: currentDate, format: "dd.MM.yyyy")
        currentShortDate = getCurrentDate(for: currentDate, format: "d")
        currentShortDay = getCurrentDate(for: currentDate, format: "E")
        
        getCurrentWeek()
    }
    
    // Получение текущей даты
    private func getCurrentDate(for date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    // Получение текущей недели
    private func getCurrentWeek() {
        let week = currentCalendar.dateInterval(of: .weekOfMonth, for: currentDate)
        
        let firstDayWeek = week?.start
        
        (1 ... 7).forEach { day in
            if let weekDay = currentCalendar.date(byAdding: .day, value: day, to: firstDayWeek!) {
                currentWeek.append(weekDay)
            }
        }
    }
}
