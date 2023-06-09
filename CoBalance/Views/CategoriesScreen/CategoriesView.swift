//
//  CategoriesView.swift
//  CoBalance
//
//  Created by Максим Боталов on 04.05.2023.
//

import SwiftUI

struct CategoriesView: View {
    
    // MARK: - СВОЙСТВА
    // Входные параметры
    @Binding var categoryType: CategoryType
    @State private var categoryLogo: String = ""
    @State private var categoryTitle: String = ""

    // Объекты среды окружения
    @EnvironmentObject private var categoryVM: CategoryViewModel
    @Environment (\.dismiss) private var dismiss
    
    // Взаимодействие с UI
    @State private var checkTitleAndLogo = false
    @State private var warningText = ""
    @State private var isSuccessfully = false
    
    // MARK: - ТЕЛО
    var body: some View {
        ZStack(alignment: .bottom) {
            // Фон
            Color.theme.backgroundPrimary.ignoresSafeArea()
            
            // Основное полотно
            VStack(alignment: .center, spacing: 16) {
                // Заголовок
                Text(categoryType == .expense ? "Expense categories" : "Income categories")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(Color.theme.textPrimary)
                    .padding(.top)
                    .padding(.horizontal)
                
                // Выбор типа
                Picker("", selection: $categoryType) {
                    ForEach(CategoryType.allCases, id: \.self) { item in
                        Text(item.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                
                // Ввод иконки + заголовка
                HStack(alignment: .center, spacing: 16) {
                    // Иконка
                    TextField("😀", text: $categoryLogo)
                        .foregroundColor(Color.theme.textPrimary)
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .multilineTextAlignment(.center)
                        .frame(width: 40, height: 40, alignment: .center)
                        .background(Color.theme.backgroundSecondary)
                        .clipShape(Circle())
                        .shadow(color: .theme.backgroundSecondary, radius: 20, x: 0, y: -30)
                        .onChange(of: categoryLogo) { newValue in
                            categoryLogo = String(categoryLogo.prefix(1))
                        }
                    
                    // Заголовок
                    TextField("Category name", text: $categoryTitle)
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .padding(.leading)
                        .frame(height: 40)
                        .frame(maxWidth: .infinity)
                        .background(Color.theme.backgroundSecondary)
                        .foregroundColor(Color.theme.textPrimary)
                        .clipShape(Capsule(style: .continuous))
                        .shadow(color: Color.theme.backgroundSecondary, radius: 20, x: 0, y: 0)
                }
                .padding(.horizontal)
                
                // Вывод предупреждения
                if checkTitleAndLogo {
                    PopupWarningView(text: $warningText)
                        .padding(.horizontal)
                }
                
                // Кнопка сохранения
                SecondaryButtonView(icon: "doc", title: "Save", isActive: !categoryLogo.isEmpty || !categoryTitle.isEmpty) {
                    // Проверка на дубликаты по названию категории
                    guard categoryVM.isDuplicate(title: categoryTitle) else {
                        warningText = "There is already such a category."
                        
                        withAnimation(.spring()) {
                            checkTitleAndLogo = true
                        }
                        
                        return
                    }
                    
                    // Проверка на заполнение иконки и названия перед сохранением
                    guard !categoryLogo.isEmpty && !categoryTitle.isEmpty else {
                        warningText = "Before saving, please enter the emoji and title."
                        
                        withAnimation(.spring()) {
                            checkTitleAndLogo = true
                        }
                        
                        return
                    }
                    
                    // Добавление новой категории
                    withAnimation(.spring()) {
                        categoryVM.addCategory(type: categoryType, title: categoryTitle, logo: categoryLogo)
                    }
                    
                    // Сброс текущих значнений
                    withAnimation(.spring()) {
                        categoryTitle = ""
                        categoryLogo = ""
                        checkTitleAndLogo = false
                        isSuccessfully = true
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        dismiss()
                    }
                }
                
                // MARK: Список категории
                categoriesList()
            }
            
            PopupSuccessfullyView(isSuccessfully: $isSuccessfully)
        }
    }
    
    // MARK: - ФУНКЦИИ && UI
    // Фильтрация всех категории на типы
    private func filteringList(for categories: [Category]) -> some View {
        Section {
            ForEach(categories) { category in
                CategoryCellView(category: category) {
                    categoryVM.deleteCategory(for: category)
                }
            }
        } header: {
            if !categories.isEmpty {
                Text("All categories".uppercased())
                    .font(.system(size: 14, weight: .bold, design: .rounded))
                    .foregroundColor(Color.theme.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    // Заполнение отфильтрованных категорий
    private func categoriesList() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .center, spacing: 8, pinnedViews: []) {
                if categoryType == .expense {
                    filteringList(for: categoryVM.categories.filter({ $0.type == .expense }))
                } else {
                    filteringList(for: categoryVM.categories.filter({ $0.type == .income }))
                }
            }
            .padding()
        }
    }
}

// MARK: - ПРЕДВАРИТЕЛЬНЫЙ ПРОСМОТР
struct CategoriesScreen_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView(categoryType: .constant(.expense))
            .environmentObject(DevelopmentPreview.instance.categoryVM)
    }
}
