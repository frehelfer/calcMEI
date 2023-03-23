//
//  Count.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 16/02/23.
//

import Foundation

struct Count: Identifiable {
    var id = UUID()
    var date = Date()
    var name: String?
    var hasToDeclare: Bool = false
    
    var inServiceProvision: Double = 0
    var inCommerce: Double = 0
    var inPassengerTransport: Double = 0
    
    var outExpenses: Double = 0
    
    
    // TODO: Change variable names
    
    var receitaBrutaAnual: Double {
        inServiceProvision + inCommerce + inPassengerTransport
    }
    
    var lucroApurado: Double {
        receitaBrutaAnual - outExpenses
    }
    
    var rendimentoIsento: Double {
        (inServiceProvision * 0.32) + (inCommerce * 0.08) + (inPassengerTransport * 0.16)
    }
    
    var rendimentoTributável: Double {
        lucroApurado - rendimentoIsento
    }
}
