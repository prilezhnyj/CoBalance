//
//  MainViewModel.swift
//  CoBalance
//
//  Created by Максим Боталов on 01.05.2023.
//

import Foundation
import Combine

class MainViewModel: ObservableObject {
    
    // MARK: - СВОЙСТВА
    // ПУБЛИЧНЫЕ СВОЙСТВА
    @Published var operations = [Operation]()
    @Published var selectedDayWeek = Date()
    
    // ПРИВАТНЫЕ СВОЙСТВА
    private var subscribers = Set<AnyCancellable>()
    private let dateService = DateService.instance
    private let dataService = DataService.instance
    
    // MARK: - ИНИЦИАЛИЗАТОР
    init() {
        addSubscribers()
    }
    
    // MARK: - МЕТОДЫ И ФУНКЦИИ
    // ДОБАВЛЕНИЕ ПОДПИСЧИКОВ COMBINE
    private func addSubscribers() {
        filteringOperations()
    }
    
    // ФУНКЦИЯ УДАЛЕНИЯ ОПЕРАЦИИ
    func deleteOperation(for operation: Operation) {
        // Поиск операции
        guard let _ = findItem(item: operation, in: operations) else {
            print("[❌] Операция не найдена")
            return
        }
        
        // Удаление операции через fakeDataServices
        //        fakeDataServices.deleteOperation(for: deletedOperation)
    }
    
    // ОБЩАЯ ФУНКЦИЯ ПОИСКА ОПЕРАЦИИ
    private func findItem(item searchItem: Operation, in array: [Operation]) -> Int? {
        for (index, item) in array.enumerated() {
            if item.id == searchItem.id {
                return index
            }
        }
        return nil
    }
    
    // Фильтрованные операции по дням
    func filteringOperations() {
        dataService.$allOperations
            .sink(receiveValue: { [weak self] returnedOperations in
                self?.operations = returnedOperations.filter({ self!.dateService.currentCalendar.isDate($0.date, inSameDayAs: self!.selectedDayWeek)})
            })
            .store(in: &subscribers)
    }
    
    func checkOperationInSelectedDay(for date: Date) -> Bool {
        if operations.filter({ self.dateService.currentCalendar.isDate($0.date, inSameDayAs: date)}).isEmpty {
            return true
        } else {
            return false
        }
    }
}
