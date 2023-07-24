//
//  CountFixture.swift
//  calcMEITests
//
//  Created by Frédéric Helfer on 14/03/23.
//

import Foundation
import CalcMEI_Core

extension Count {
    static func makeCount(
        id: UUID = UUID(),
        date: Date = Date(),
        name: String? = nil,
        inServiceProvision: Double = 100,
        inCommerce: Double = 100,
        inPassengerTransport: Double = 100,
        outExpenses: Double = 100
    ) -> Count {
        Count(
            id: id,
            date: date,
            name: name,
            inServiceProvision: inServiceProvision,
            inCommerce: inCommerce,
            inPassengerTransport: inPassengerTransport,
            outExpenses: outExpenses)
    }
}
