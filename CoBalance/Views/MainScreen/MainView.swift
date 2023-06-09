//
//  MainScreenView.swift
//  CoBalance
//
//  Created by Максим Боталов on 01.05.2023.
//

import SwiftUI

struct MainView: View {
    
    // MARK: - СВОЙСТВА
    // Объекты среды окружения
    @EnvironmentObject private var mainViewModel: MainViewModel
    
    // Взаимодействие с UI
    @State private var showOperation = false
    @State private var showInfoScreen = false
    @State private var newOperation = false
    
    // Временая переменная
    @State private var currentOperation = Operation(date: .now, amount: 100, category: .init(type: .expense, title: "Title", logo: "Logo"), description: "")
    
    
    // MARK: - ТЕЛО
    var body: some View {
        ZStack(alignment: .bottom) {
            // Цвет фона
            Color.theme.backgroundPrimary.ignoresSafeArea()
            
            // Основное полотно
            VStack(alignment: .center, spacing: 16) {
                // Верхний бар с датой
                MainTopBarView(showSettings: .constant(false), newOperation: $newOperation)
                    .padding(.horizontal)
                    .padding(.top, 16)
                    .sheet(isPresented: $newOperation) { NewOperationView() }
                
                MainInfoWidgetView(action: {
                    showInfoScreen = true
                })
                .sheet(isPresented: $showInfoScreen, content: {
                    // Переход к детальной информации
                })
                .padding(.horizontal)
                
                // Список операции
                operationsList()
                    .disabled(showOperation ? true : false)
            }
            
            // Всплывающее окно с информацией
            MainDetailedCellView(currentOperation: currentOperation, showOperation: $showOperation)
                .offset(y: showOperation ? 0 : 300)
                .transition(.move(edge: .bottom))
        }
        .animation(.spring(), value: showOperation)
    }
    
    // MARK: - ФУНКЦИИ && UI
    // Фильтрация всех операции по типу
    private func filteringList(for operations: [Operation], header: String) -> some View {
        Section {
            ForEach(operations) { operation in
                MainOperationCellView(operation: operation)
                    .onTapGesture {
                        DispatchQueue.main.async {
                            currentOperation = operation
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: .init(block: {
                                showOperation = true
                            }))
                        }
                    }
            }
        } header: {
            MainHeaderListView(header: header, operations: operations)
        }
    }
    
    // Заполнение отфильтрованных операций
    private func operationsList() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .center, spacing: 8, pinnedViews: []) {
                FullWeekView().padding(.bottom)
                
                
                filteringList(for: mainViewModel.operations.filter({ $0.category.type == .expense }), header: "Expense")
                filteringList(for: mainViewModel.operations.filter({ $0.category.type == .income }), header: "Income")
            }
            .padding()
        }
    }
}

// MARK: - ПРЕДВАРИТЕЛЬНЫЙ ПРОСМОТР
struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(MainViewModel())
    }
}
