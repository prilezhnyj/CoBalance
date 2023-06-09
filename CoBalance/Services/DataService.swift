//
//  DataServices.swift
//  CoBalance
//
//  Created by Maxim Botalov on 23.05.2023.
//

import Foundation

class DataService {
    
    @Published var allOperations = [Operation]()
    @Published var allCategories = [Category]()
    
    static var instance = DataService()
    
    private init() {
        getFakeOperations()
        getFakeCategories()
    }
    
    // MARK: Удаление операции
    func deleteOperation(for operation: Int) {
        allOperations.remove(at: operation)
    }
    
    // MARK: Удаление операции
    func deleteCategory(for category: Int) {
        allCategories.remove(at: category)
    }
    
    // MARK: Добавление новой категории
    func addCategory(for category: Category) {
        allCategories.insert(category, at: 0)
    }
    
    
    private func getFakeOperations() {
        allOperations.append(contentsOf: [
            Operation(date: .now, amount: 100, category: Category(type: .expense, title: "Products", logo: "🥬"), description: ""),
            Operation(date: .now, amount: 64, category: Category(type: .expense, title: "Transport", logo: "🚎"), description: ""),
            Operation(date: .now, amount: 1029, category: Category(type: .expense, title: "Hobby", logo: "👟"), description: ""),
            Operation(date: .now, amount: 20102, category: Category(type: .income, title: "Salary", logo: "💰"), description: ""),
            Operation(date: .now, amount: 31709, category: Category(type: .income, title: "Savings", logo: "💸"), description: "")]
        )
    }
    
    private func getFakeCategories() {
        allCategories.append(Category(type: .expense, title: "Products", logo: "🥬"))
        allCategories.append(Category(type: .expense, title: "Transport", logo: "🚎"))
        allCategories.append(Category(type: .expense, title: "Home", logo: "🏠"))
        allCategories.append(Category(type: .expense, title: "Sweets", logo: "🍭"))
        allCategories.append(Category(type: .expense, title: "Hobby", logo: "👟"))
        // ---------- //
        allCategories.append(Category(type: .income, title: "Salary", logo: "💰"))
        allCategories.append(Category(type: .income, title: "Donations", logo: "🤑"))
        allCategories.append(Category(type: .income, title: "Savings", logo: "💸"))
        allCategories.append(Category(type: .income, title: "Inestitions", logo: "💶"))
    }
}
