//
//  Operation.swift
//  CoBalance
//
//  Created by Максим Боталов on 01.05.2023.
//

import Foundation

// MARK: - МОДЕЛЬ ОПЕРАЦИИ
struct Operation: Identifiable {
    var id = UUID()
    var date: Date
    var amount: Float
    var category: Category
    var description: String
}
