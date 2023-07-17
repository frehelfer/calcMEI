//
//  AnalyticsServiceSpy.swift
//  calcMEITests
//
//  Created by Frédéric Helfer on 12/07/23.
//

import Foundation
import CalcMEI_Core

class AnalyticsServiceSpy: AnalyticsServiceProtocol {
    
    var calledLogEvent: Bool = false
    
    func logEvent(name: String, params: [String : Any]?) {
        calledLogEvent = true
    }
    
}
