//
//  OperationModel.swift
//  CoBalance
//
//  Created by Максим Боталов on 01.05.2023.
//

import Foundation

// MARK: - МОДЕЛЬ ОПЕРАЦИИ
struct OperationModel: Identifiable {
    var id = UUID()
    var date: Date
    var amount: Float
    var category: CategoryModel
    var description: String
}
