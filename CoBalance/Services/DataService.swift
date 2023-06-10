//
//  DataService.swift
//  CoBalance
//
//  Created by Maxim Botalov on 23.05.2023.
//

import Foundation

class DataService {
    
    @Published var allOperations = [OperationModel]()
    @Published var allCategories = [CategoryModel]()
    
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
    func addCategory(for category: CategoryModel) {
        allCategories.insert(category, at: 0)
    }
    
    
    private func getFakeOperations() {
        allOperations.append(contentsOf: [
            OperationModel(date: .now, amount: 100, category: CategoryModel(type: .expense, title: "Products", logo: "🥬"), description: ""),
            OperationModel(date: .now, amount: 64, category: CategoryModel(type: .expense, title: "Transport", logo: "🚎"), description: ""),
            OperationModel(date: .now, amount: 1029, category: CategoryModel(type: .expense, title: "Hobby", logo: "👟"), description: ""),
            OperationModel(date: .now, amount: 20102, category: CategoryModel(type: .income, title: "Salary", logo: "💰"), description: ""),
            OperationModel(date: .now, amount: 31709, category: CategoryModel(type: .income, title: "Savings", logo: "💸"), description: "")]
        )
    }
    
    private func getFakeCategories() {
        allCategories.append(CategoryModel(type: .expense, title: "Products", logo: "🥬"))
        allCategories.append(CategoryModel(type: .expense, title: "Transport", logo: "🚎"))
        allCategories.append(CategoryModel(type: .expense, title: "Home", logo: "🏠"))
        allCategories.append(CategoryModel(type: .expense, title: "Sweets", logo: "🍭"))
        allCategories.append(CategoryModel(type: .expense, title: "Hobby", logo: "👟"))
        // ---------- //
        allCategories.append(CategoryModel(type: .income, title: "Salary", logo: "💰"))
        allCategories.append(CategoryModel(type: .income, title: "Donations", logo: "🤑"))
        allCategories.append(CategoryModel(type: .income, title: "Savings", logo: "💸"))
        allCategories.append(CategoryModel(type: .income, title: "Inestitions", logo: "💶"))
    }
}
