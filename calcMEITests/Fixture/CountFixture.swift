//
//  CountFixture.swift
//  calcMEITests
//
//  Created by Frédéric Helfer on 14/03/23.
//

import Foundation

@testable import calcMEI

extension Count {
    static func fixture(
        inServiceProvision: Double = 0,
        inCommerce: Double = 0,
        inPassengerTransport: Double = 0,
        outExpenses: Double = 0
    ) -> Count {
        .init(
            id: UUID(),
            date: Date(),
            inServiceProvision: inServiceProvision,
            inCommerce: inCommerce,
            inPassengerTransport: inPassengerTransport,
            outExpenses: outExpenses)
    }
}
