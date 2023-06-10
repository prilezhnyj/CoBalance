//
//  СategoriesGridView.swift
//  CoBalance
//
//  Created by Максим Боталов on 03.05.2023.
//

import SwiftUI

struct СategoriesGridView: View {
    
    // MARK: - СВОЙСТВА
    // Входные параметры
    @Binding var showAllCategories: Bool
    @Binding var addCategory: Bool
    @Binding var operationType: CategoryType
    @Binding var operationCategory: CategoryModel
    
    // Объекты среды окружения
    @EnvironmentObject private var categoryViewModel: CategoryViewModel
    
    // Приватные свойства
    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 8, alignment: .center),
        GridItem(.flexible(), spacing: 8, alignment: .center),
        GridItem(.flexible(), spacing: 8, alignment: .center),
        GridItem(.flexible(), spacing: 8, alignment: .center),
    ]
    
    // MARK: - ТЕЛО
    var body: some View {
        allView()
    }
    
    // MARK: - ФУНКЦИИ && UI
    // Заголовок + кнопка показать / скрыть
    private func headerView() -> some View {
        HStack(alignment: .center, spacing: 0) {
            // Заголовок
            Text("Categories")
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .foregroundColor(Color.theme.textPrimary)
            
            Spacer()
            
            // Кнопка показать / скрыть
            Button {
                withAnimation(.spring()) {
                    showAllCategories.toggle()
                }
            } label: {
                Text(showAllCategories ? "Hide" : "Show")
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                    .foregroundColor(showAllCategories ? Color.theme.expense : Color.theme.textSecondary)
                    .opacity(categoryViewModel.categories.filter({ $0.type == operationType }).count > 3 ? 1 : 0)
            }
            .disabled(categoryViewModel.categories.filter({ $0.type == operationType }).count > 3 ? false : true)
        }
        .padding(16)
    }
    
    // Вид категории
    private func categories(for array: [CategoryModel]) -> some View {
        ForEach(array) { category in
            VStack {
                // Иконка
                Text(category.logo)
                    .frame(width: 40, height: 40, alignment: .center)
                    .background(operationCategory.id == category.id ? Color.theme.income : Color.theme.backgroundSecondary)
                    .clipShape(Circle())
                
                // Заголовок
                Text(category.title)
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                    .foregroundColor(operationCategory.id == category.id ? Color.theme.income : Color.theme.textPrimary)
                    .lineLimit(1)
                    .truncationMode(.tail)
            }
            .onTapGesture {
                withAnimation(.spring()) {
                    operationCategory = category
                }
            }
            .onAppear {
                DispatchQueue.main.async {
                    operationCategory = array.first ?? CategoryModel(type: .expense, title: "", logo: "")
                }
            }
        }
    }
    
    // Сетка с категориями
    private func gridCategories() -> some View {
        LazyVGrid(columns: columns, alignment: .center, spacing: 8) {
            if operationType == .expense {
                categories(for: categoryViewModel.categories.filter({ $0.type == .expense }))
            }
            
            if operationType == .income {
                categories(for: categoryViewModel.categories.filter({ $0.type == .income }))
            }
            
            // Кнопка добвления новой категории
            Button {
                addCategory = true
                showAllCategories = false
            } label: {
                VStack {
                    // Иконка
                    Image(systemName: "plus")
                        .foregroundColor(Color.theme.buttonText)
                        .frame(width: 40, height: 40, alignment: .center)
                        .background(Color.theme.backgroundSecondary)
                        .clipShape(Circle())
                    
                    // Заголовок
                    Text("Add")
                        .font(.system(size: 14, weight: .regular, design: .rounded))
                        .foregroundColor(Color.theme.textPrimary)
                        .lineLimit(1)
                        .truncationMode(.tail)
                }
            }
            .sheet(isPresented: $addCategory) {
                CategoriesView(categoryType: $operationType)
            }
        }
        .padding(.horizontal, 16)
    }
    
    // Сетка категории обёрнутая в СкроллВью
    private func gridInScrollView() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            gridCategories()
        }
    }
    
    // Итоговая вью
    private func allView() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            headerView()
            gridInScrollView()
        }
        .frame(height: showAllCategories ? 220 : 130)
        .frame(maxWidth: .infinity)
        .background(Color.theme.backgroundPrimary)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .animation(.spring(), value: showAllCategories)
        .shadow(color: .theme.backgroundSecondary, radius: 20, x: 0, y: 0)
    }
}

// MARK: - ПРЕДВАРИТЕЛЬНЫЙ ПРОСМОТР
struct NewOperationCategories_Previews: PreviewProvider {
    static var previews: some View {
        СategoriesGridView(showAllCategories: .constant(true), addCategory: .constant(false), operationType: .constant(.expense), operationCategory: .constant(CategoryModel(type: .expense, title: "", logo: "")))
            .environmentObject(DevelopmentPreview.instance.categoryVM)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

