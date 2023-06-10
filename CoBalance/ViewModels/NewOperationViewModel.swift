//
//  NewOperationViewModel.swift
//  CoBalance
//
//  Created by Maxim Botalov on 22.05.2023.
//

import Foundation
import Combine

class NewOperationViewModel: ObservableObject {
    
    // MARK: - INSTANCE FAKEDATASERVICES
    private let dataService = DataService.instance
    
    // MARK: - SAVING THE OPERATION AND TRANSFERRING IT TO A FAKE DATE
    func savedOperation(type: CategoryType, amount: String, category: CategoryModel, description: String) {
//        guard let amountFloat = Float(amount) else { return }
//        let operation = Operation(date: .now, amount: amountFloat, category: category, description: description)
    }
}
