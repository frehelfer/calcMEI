//
//  Count.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 16/02/23.
//

import Foundation

struct Count: Identifiable {
    var id = UUID()
    
    var inServiceRendering: String
    var inCommerce: String
    var inPassengerTransport: String
    
    var outExpenses: String
    
}
