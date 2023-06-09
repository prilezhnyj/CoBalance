//
//  Color.swift
//  CoBalance
//
//  Created by Максим Боталов on 05.05.2023.
//

import SwiftUI

extension Color {
    static let theme = MyTheme()
}

struct MyTheme {
    let backgroundPrimary = Color("Background_Primary")
    let backgroundSecondary = Color("Background_Secondary")
    let buttonBackground = Color("Button_Background")
    let buttonText = Color("Button_Text")
    let expense = Color("Expense")
    let income = Color("Income")
    let textPrimary = Color("Text_Primary")
    let textSecondary = Color("Text_Secondary")
    
    let backgroundPrimarySelected = Color("Background_Primary_Selected")
    let backgroundSecondarySelected = Color("Background_Secondary_Selected")
    
    let textPrimarySelected = Color("Text_Primary_Selected")
    let textSecondarySelected = Color("Text_Secondary_Selected")
}
