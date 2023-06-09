//
//  Date.swift
//  CoBalance
//
//  Created by Максим Боталов on 29.05.2023.
//

import Foundation

extension Date {
    func formatter(for date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
}
