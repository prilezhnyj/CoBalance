//
//  CoBalanceApp.swift
//  CoBalance
//
//  Created by Максим Боталов on 30.04.2023.
//

import SwiftUI

@main
struct CoBalanceApp: App {
    
    // MARK: - ОБЪЕКТЫ ОКРУЖЕНИЯ
    @StateObject private var mainScreenViewModel = MainViewModel()
    @StateObject private var categoryViewModel = CategoryViewModel()
    
    // MARK: - ТЕЛО
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(mainScreenViewModel)
                .environmentObject(categoryViewModel)
        }
    }
}
