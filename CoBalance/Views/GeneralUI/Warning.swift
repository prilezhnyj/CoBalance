//
//  Warning.swift
//  CoBalance
//
//  Created by Максим Боталов on 25.05.2023.
//

import SwiftUI

struct PopupWarning: View {
    
    // MARK: -  Input property
    @Binding var text: String
    
    // MARK: - Body
    var body: some View {
        Text(text)
            .font(.system(size: 12, weight: .regular, design: .rounded))
            .multilineTextAlignment(.leading)
            .foregroundColor(Color.theme.expense)
    }
}


struct Warning_Previews: PreviewProvider {
    static var previews: some View {
        PopupWarning(text: .constant("Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor."))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
