//
//  Currency.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 20/02/23.
//

import Foundation
import CurrencyFormatter

extension String {
    
    func currencyFormattedToDouble() -> Double {
        let currencyFormatter = CurrencyFormatter {
            $0.currency = .brazilianReal
            $0.locale = CurrencyLocale.portugueseBrazil
            $0.hasDecimals = true
        }
        
        let unformatted = currencyFormatter.unformatted(string: self)
        let double = currencyFormatter.double(from: unformatted ?? "")
        
        return double ?? 0.0
    }
}

extension Double {
    
    func currencyFormatFromDouble() -> String {
        let currencyFormatter = CurrencyFormatter {
            $0.currency = .brazilianReal
            $0.locale = CurrencyLocale.portugueseBrazil
            $0.hasDecimals = true
        }
        
        let formatted = currencyFormatter.string(from: self)
        
        return formatted ?? ""
    }
}
