//
//  MainInfoBanner.swift
//  CoBalance
//
//  Created by Maxim Botalov on 23.05.2023.
//

import SwiftUI

struct MainInfoBannerView: View {
    
    // MARK: - СВОЙСТВА
    // Входные параметры
    let topTitle: String
    let lowerTitle: String
    
    // MARK: - ТЕЛО
    var body: some View {
        // Основное полотно
        VStack(alignment: .center, spacing: 8) {
            // Верх
            Text(topTitle)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(Color.theme.textPrimary)
                .frame(alignment: .center)
            
            // Низ
            Text(lowerTitle)
                .font(.system(size: 14, weight: .regular, design: .rounded))
                .foregroundColor(Color.theme.textSecondary)
                .frame(alignment: .center)
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 32)
        .background(Color.theme.backgroundPrimary)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.theme.backgroundSecondary, radius: 20, x: 0, y: 20)
    }
}

// MARK: - ПРЕДВАРИТЕЛЬНЫЙ ПРОСМОТР
struct MainInfoBanner_Previews: PreviewProvider {
    static var previews: some View {
        MainInfoBannerView(topTitle: "Top title example", lowerTitle: "Lower title example")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
