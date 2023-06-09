//
//  InfoWidgetViewModel.swift
//  CoBalance
//
//  Created by Максим Боталов on 29.05.2023.
//

import Foundation
import Combine

class MainInfoWidgetViewModel: ObservableObject {
    
    // MARK: - СВОЙСТВА
    // ПУБЛИЧНЫЕ СВОЙСТВА
    @Published var operations = [Operation]()
    @Published var currentMonth = ""
    
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
        dataService.$allOperations
            .sink { [weak self] operations in
                self?.operations = operations
            }
            .store(in: &subscribers)
        
        dateService.$currentMonth
            .sink { [weak self] currentMonthDateService in
                self?.currentMonth = currentMonthDateService
            }
            .store(in: &subscribers)
    }
    
    func getAmount(for type: CategoryType) -> Float {
        return operations.filter({ $0.category.type == type }).map({ $0.amount }).reduce(0, { $0 + $1 })
    }
    
    // Получить разницу между доходом и разсодом
    func getDifferenceAmounts() -> Float {
        let expenseAmount = operations.filter({ $0.category.type == .expense }).map({ $0.amount }).reduce(0, { $0 + $1 })
        let incomeAmount = operations.filter({ $0.category.type == .income }).map({ $0.amount }).reduce(0, { $0 + $1 })
        return incomeAmount - expenseAmount
    }
    
}
