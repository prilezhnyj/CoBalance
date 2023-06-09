//
//  Formatter.swift
//  CoBalance
//
//  Created by Максим Боталов on 02.05.2023.
//

import Foundation

extension Formatter {
    
    /// Formatting a number to fit the desired format
    ///```
    /// 100 to $100.00
    /// 1000 to $1,000.00
    ///```
    static let currentFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
}

extension Numeric {
    
    /// Formatting a number into a string
    ///```
    /// 100 to "$100.00"
    /// 1000 to "$1,000.00"
    ///```
    var currentFormatter: String { Formatter.currentFormatter.string(for: self) ?? "" }
}
