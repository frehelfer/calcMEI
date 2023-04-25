//
//  Configuration.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 25/04/23.
//

import Foundation

enum Configuration {
    
    private static func value<T>(for key: Configuration.Key) throws -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey: key.rawValue) else {
            throw ConfigurationError.missingKey
        }

        switch object {
        case let value as T:
            return value
        case let string as String:
            guard let value = T(string) else {
                fallthrough
            }
            return value
        default:
            throw ConfigurationError.invalidValue
        }
    }
    
    static var anoExercicio: String {
        return try! Configuration.value(for: .anoExercicio)
    }
    
    static var anoCalendario: String {
        return try! Configuration.value(for: .anoCalendario)
    }
    
    static var rendimentoIsentoServico: Double {
        return try! Configuration.value(for: .rendimentoIsentoServico)
    }
    
    static var rendimentoIsentoComercio: Double {
        return try! Configuration.value(for: .rendimentoIsentoComercio)
    }
    
    static var rendimentoIsentoTransporte: Double {
        return try! Configuration.value(for: .rendimentoIsentoTransporte)
    }
    
    static var rendimentoTributavelLimite: Double {
        return try! Configuration.value(for: .rendimentoTributavelLimite)
    }
    
}

// MARK: - Nested Types
private extension Configuration {

    enum Key: String {
        
        case anoExercicio = "ANO_EXERCICIO"
        case anoCalendario = "ANO_CALENDARIO"
        
        case rendimentoIsentoServico = "RENDIMENTO_ISENTO_SERVICO"
        case rendimentoIsentoComercio = "RENDIMENTO_ISENTO_COMERCIO"
        case rendimentoIsentoTransporte = "RENDIMENTO_ISENTO_TRANSPORTE"
        
        case rendimentoTributavelLimite = "RENDIMENTO_TRIBUTAVEL_LIMITE"
        
    }

    enum ConfigurationError: Error {
        case missingKey
        case invalidValue
    }
}
