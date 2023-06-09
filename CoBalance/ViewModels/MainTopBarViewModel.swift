//
//  MainTopBarViewModel.swift
//  CoBalance
//
//  Created by Максим Боталов on 29.05.2023.
//

import Foundation
import Combine

class MainTopBarViewModel: ObservableObject {
    
    // MARK: - СВОЙСТВА
    // ПУБЛИЧНЫЕ СВОЙСТВА
    @Published var currentDay = ""
    @Published var currentFullDate = ""
    
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
            .sink { [weak self] currentDayDateService in
                self?.currentDay = currentDayDateService
            }
            .store(in: &subscribers)
        
        dateService.$currentFullDate
            .sink { [weak self] currentFullDateDateService in
                self?.currentFullDate = currentFullDateDateService
            }
            .store(in: &subscribers)
    }
}
