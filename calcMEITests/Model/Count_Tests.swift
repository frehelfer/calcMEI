//
//  CountTest.swift
//  calcMEITests
//
//  Created by Frédéric Helfer on 14/03/23.
//

import XCTest
import CalcMEI_Core
@testable import calcMEI

final class CountTest: XCTestCase {
    private let sut = Count(id: .init(), date: .init(), inServiceProvision: 100, inCommerce: 100, inPassengerTransport: 100, outExpenses: 100)
    
    func test_Count_receitaBrutaAnual() {
        let correct: Double = 300
        let result = sut.receitaBrutaAnual
        
        XCTAssertEqual(result, correct)
    }
    
    func test_Count_lucroApurado() {
        let correct: Double = 200
        let result = sut.lucroApurado
        
        XCTAssertEqual(result, correct)
    }
    
    func test_Count_rendimentoIsento() {
        let correct: Double = 56
        let result = sut.rendimentoIsento
        
        XCTAssertEqual(result, correct)
    }
    
    func test_Count_rendimentoTributável() {
        let correct: Double = 144
        let result = sut.rendimentoTributável
        
        XCTAssertEqual(result, correct)
    }

}  
