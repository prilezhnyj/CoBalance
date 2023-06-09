//
//  DevelopmentPreview.swift
//  CoBalance
//
//  Created by Максим Боталов on 17.05.2023.
//

import SwiftUI

extension PreviewProvider {
    
    static var development: DevelopmentPreview {
        return DevelopmentPreview.instance
    }
    
}

class DevelopmentPreview {
    
    static let instance = DevelopmentPreview()
    
    private init() {}
    
    let mainVM = MainViewModel()
    let categoryVM = CategoryViewModel()
    
    let operation = Operation(date: .now, amount: 100, category: Category(type: .expense, title: "Products", logo: "🍞"), description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
        
}
