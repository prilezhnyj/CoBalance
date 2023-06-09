//
//  NewOperationView.swift
//  CoBalance
//
//  Created by Максим Боталов on 02.05.2023.
//

import SwiftUI

struct NewOperationView: View {
    
    // MARK: - СВОЙСТВА
    // Входные параметры
    @State private var operationType: CategoryType = .expense
    @State private var operationAmount: String = ""
    @State private var operationCategory: Category = .init(type: .expense, title: "Title", logo: "Logo")
    @State private var operationDescription: String = ""
    
    // Объекты среды окружения
    @EnvironmentObject private var categoryViewModel: CategoryViewModel
    @StateObject private var newOperationViewModel = NewOperationViewModel()
    @Environment (\.dismiss) private var dismiss
    
    // Взаимодействие с UI
    @State private var showAllCategories: Bool = false
    @State private var showNumpad: Bool = false
    @State private var checkAmount: Bool = false
    @State private var addCategory: Bool = false
    @State private var warningText = ""
    
    //MARK: - ТЕЛО
    var body: some View {
        ZStack(alignment: .bottom) {
            // Фон
            Color.theme.backgroundPrimary.ignoresSafeArea()
            
            // Основное полотно
            VStack(alignment: .center, spacing: 16) {
                // Заголовок
                Text(operationType == .expense ? "New expense" : "New income")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(Color.theme.textPrimary)
                    .padding(.top)
                
                // Выбор типа операции
                Picker("", selection: $operationType) {
                    ForEach(CategoryType.allCases, id: \.self) { item in
                        Text(item.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                
                // Ввод суммы + предупреждение
                VStack(alignment: .center, spacing: 0) {
                    Text(operationAmount.isEmpty ? "Amount" : operationAmount + "₽")
                        .foregroundColor(operationAmount == "" ? Color.theme.textSecondary : Color.theme.textPrimary)
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .frame(height: 48)
                        .animation(.spring(), value: operationAmount.isEmpty)
                        .onTapGesture {
                            showNumpad.toggle()
                            checkAmount = false
                        }
                    
                    // Предупреждение, если сумма не была введена
                    if checkAmount {
                        PopupWarningView(text: $warningText)
                    }
                }
                
                // Сетка с категориями
                СategoriesGridView(showAllCategories: $showAllCategories, addCategory: $addCategory, operationType: $operationType, operationCategory: $operationCategory)
                
                Divider()
                    .padding(.top)
                
                // Поле описания
                TextEditor(text: $operationDescription)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundColor(Color.theme.textPrimary)
                    .scrollContentBackground(.hidden)
                    .overlay(alignment: .topLeading) {
                        Text("Start typing here... (optional)")
                            .font(.system(size: 14, weight: .regular, design: .rounded))
                            .foregroundColor(Color.theme.textSecondary)
                            .offset(x: 5, y: 8)
                            .opacity(operationDescription.isEmpty ? 1 : 0)
                    }
                    .frame(minHeight: 200, maxHeight: .infinity)
                    .disabled(showNumpad ? true : false)
                
                Spacer()
                
                // Кнопка сохранения операции
                PrimaryButtonView(title: "Save", isActive: true, action: {
                    // Проверка введена ли сумма и выбрана ли операция перед сохранением
                    guard operationAmount != "0" && operationAmount != "" else {
                        warningText = "Please enter the transaction amount. It will not be possible to save the operation without the amount."
                        withAnimation(.spring()) { checkAmount = true }
                        return
                    }
                    
                    // Сохранение
                    newOperationViewModel.savedOperation(type: operationType, amount: operationAmount, category: operationCategory, description: operationDescription)
                    
                    // Закрытие вью
                    dismiss()
                    
                })
                .opacity(operationAmount == "0" || operationAmount == "" ? 0.1 : 1)
                .opacity(showNumpad ? 0 : 1)
                
//                Spacer()
            }
            .padding()
            
            // Кастомный нампад
            NumpadView(amount: $operationAmount, closeNumpad: $showNumpad)
                .offset(y: showNumpad ? 0 : 350)
                .transition(.move(edge: .bottom))
        }
        .animation(.spring(), value: showNumpad)
    }
}

// MARK: - ПРЕДВАРИТЕЛЬНЫЙ ПРОСМОТР
struct NewOperation_Previews: PreviewProvider {
    static var previews: some View {
        NewOperationView()
            .environmentObject(DevelopmentPreview.instance.categoryVM)
    }
}
