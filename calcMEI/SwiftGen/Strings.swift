// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum S {
  internal enum Home {
    /// Localizable.strings
    ///   calcMEI
    /// 
    ///   Created by Frédéric Helfer on 17/04/23.
    internal static let title = S.tr("Localizable", "Home.Title", fallback: "calcMEI")
    internal enum InfoLabel {
      /// Ano-Calendário de 2022 - Exercício de 2023
      internal static let text = S.tr("Localizable", "Home.InfoLabel.Text", fallback: "Ano-Calendário de 2022 - Exercício de 2023")
    }
    internal enum NewConsultButton {
      /// Nova consulta
      internal static let title = S.tr("Localizable", "Home.NewConsultButton.Title", fallback: "Nova consulta")
    }
    internal enum SavedConsultsButton {
      /// Consultas salvas
      internal static let title = S.tr("Localizable", "Home.SavedConsultsButton.Title", fallback: "Consultas salvas")
    }
    internal enum TitleLabel {
      /// Calculadora Declaração 
      ///  IRPF - MEI
      internal static let text = S.tr("Localizable", "Home.TitleLabel.Text", fallback: "Calculadora Declaração \n IRPF - MEI")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension S {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
