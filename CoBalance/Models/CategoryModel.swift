//
//  CategoryModel.swift
//  CoBalance
//
//  Created by Максим Боталов on 30.04.2023.
//

import Foundation

// MARK: - МОДЕЛЬ КАТЕГОРИИ
struct CategoryModel: Identifiable, Hashable {
    var id = UUID()
    var type: CategoryType
    var title: String
    var logo: String
}

// MARK: - ТИП КАТЕГОРИИ
enum CategoryType: String, Hashable, CaseIterable {
    case expense = "Expense"
    case income = "Income"
}
