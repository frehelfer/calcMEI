//
//  CountFixture.swift
//  calcMEITests
//
//  Created by Frédéric Helfer on 14/03/23.
//

import Foundation

@testable import calcMEI

extension Count {
    static func makeCount(
        id: UUID = UUID(),
        date: Date = Date(),
        name: String? = UUID().uuidString,
        hasToDeclare: Bool = Bool.random(),
        inServiceProvision: Double = Double.random(in: 0..<30_000),
        inCommerce: Double = Double.random(in: 0..<30_000),
        inPassengerTransport: Double = Double.random(in: 0..<30_000),
        outExpenses: Double = Double.random(in: 0..<30_000)
    ) -> Count {
        Count(
            id: id,
            date: date,
            name: name,
            hasToDeclare: hasToDeclare,
            inServiceProvision: inServiceProvision,
            inCommerce: inCommerce,
            inPassengerTransport: inPassengerTransport,
            outExpenses: outExpenses)
    }
}
