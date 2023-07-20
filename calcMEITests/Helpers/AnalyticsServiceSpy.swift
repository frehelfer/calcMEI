//
//  AnalyticsServiceSpy.swift
//  calcMEITests
//
//  Created by Frédéric Helfer on 12/07/23.
//

import Foundation
import CalcMEI_Core

class AnalyticsServiceSpy: AnalyticsServiceProtocol {
    
    private(set) var calledLogEvent: Bool = false
    private(set) var eventName: String? = nil
    private(set) var eventParams: [String: Any]? = nil
    
    func logEvent(name: String, params: [String : Any]?) {
        calledLogEvent = true
        eventName = name
        eventParams = params
    }
    
}
