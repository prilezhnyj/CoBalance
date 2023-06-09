//
//  CategoryViewModel.swift
//  CoBalance
//
//  Created by Максим Боталов on 03.05.2023.
//

import Foundation
import Combine

class CategoryViewModel: ObservableObject {
    @Published var categories = [Category]()
    
    // ПРИВАТНЫЕ СВОЙСТВА
    private var subscribers = Set<AnyCancellable>()
    private let dataService = DataService.instance
    
    init() {
        addSubscribers()
    }
    
    // Сombine
    private func addSubscribers() {
        dataService.$allCategories
            .sink { [weak self] returnedCategories in
                self?.categories = returnedCategories
            }
            .store(in: &subscribers)
        
        // Синк фейковой даты
        /*
        fakeDataServices.$allCategories
            .sink { [weak self] fakeCategories in
                self?.categories = fakeCategories
            }
            .store(in: &subscribers)
         */
    }
    
    // Добавление новой категории
    func addCategory(type: CategoryType, title: String, logo: String) {}
    
    // Функция удаления категории
    func deleteCategory(for category: Category) {
        // Поиск операции
        guard let deleteCategory = findItem(item: category, in: categories) else {
            print("[❌] Операция не найдена")
            return
        }
        
        // Удаление операции через fakeDataServices
        dataService.deleteCategory(for: deleteCategory)
    }
    
    func isDuplicate(title: String) -> Bool {
        guard categories.contains(where: { $0.title == title }) else { return true }
        return false
    }
    
    // Функция поиска категории
    private func findItem(item searchItem: Category, in array: [Category]) -> Int? {
        for (index, item) in array.enumerated() {
            if item.id == searchItem.id {
                return index
            }
        }
        return nil
    }
}
