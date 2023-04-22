// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum S {
  internal enum Consults {
    /// Consultas Salvas
    internal static let title = S.tr("Localizable", "Consults.Title", fallback: "Consultas Salvas")
  }
  internal enum Expenses {
    /// Despesas Anuais
    internal static let title = S.tr("Localizable", "Expenses.Title", fallback: "Despesas Anuais")
    internal enum ExpensesLabel {
      /// Pró-labore, DAS, Mercadorias, Aluguel, Água, Luz e Tel.
      internal static let text = S.tr("Localizable", "Expenses.ExpensesLabel.Text", fallback: "Pró-labore, DAS, Mercadorias, Aluguel, Água, Luz e Tel.")
    }
    internal enum NextButton {
      /// Resultado
      internal static let title = S.tr("Localizable", "Expenses.NextButton.Title", fallback: "Resultado")
    }
  }
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
    internal enum LawLabel {
      /// http://normas.receita.fazenda.gov.br/sijut2consulta/link.action?naoPublicado=&idAto=123534&visao=anotado
      internal static let url = S.tr("Localizable", "Home.LawLabel.Url", fallback: "http://normas.receita.fazenda.gov.br/sijut2consulta/link.action?naoPublicado=&idAto=123534&visao=anotado")
      internal enum First {
        /// Conforme Instrução Normativa 
        internal static let text = S.tr("Localizable", "Home.LawLabel.First.Text", fallback: "Conforme Instrução Normativa ")
      }
      internal enum Second {
        /// RFB n.2077
        internal static let text = S.tr("Localizable", "Home.LawLabel.Second.Text", fallback: "RFB n.2077")
      }
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
      internal enum FirstLine {
        /// Calculadora Declaração
        internal static let text = S.tr("Localizable", "Home.TitleLabel.FirstLine.Text", fallback: "Calculadora Declaração")
      }
      internal enum SecondLine {
        /// 
        ///  IRPF - MEI
        internal static let text = S.tr("Localizable", "Home.TitleLabel.SecondLine.Text", fallback: "\n IRPF - MEI")
      }
    }
  }
  internal enum Income {
    /// Receita Bruta Anual
    internal static let title = S.tr("Localizable", "Income.Title", fallback: "Receita Bruta Anual")
    internal enum CommerceLabel {
      /// Comércio, Indústria e 
      ///  Transporte de Cargas
      internal static let text = S.tr("Localizable", "Income.CommerceLabel.Text", fallback: "Comércio, Indústria e \n Transporte de Cargas")
    }
    internal enum NextButton {
      /// Próximo
      internal static let title = S.tr("Localizable", "Income.NextButton.Title", fallback: "Próximo")
    }
    internal enum ServicesLabel {
      /// Prestação de Serviços
      internal static let text = S.tr("Localizable", "Income.ServicesLabel.Text", fallback: "Prestação de Serviços")
    }
    internal enum TransportLabel {
      /// Transporte de Passageiros
      internal static let text = S.tr("Localizable", "Income.TransportLabel.Text", fallback: "Transporte de Passageiros")
    }
    internal enum InfoLabel {
      /// Insira abaixo os valores recebidos em cada categoria.
      internal static let text = S.tr("Localizable", "Income.infoLabel.Text", fallback: "Insira abaixo os valores recebidos em cada categoria.")
    }
  }
  internal enum Result {
    /// Resultado
    internal static let title = S.tr("Localizable", "Result.Title", fallback: "Resultado")
    internal enum PopButton {
      /// Início
      internal static let title = S.tr("Localizable", "Result.PopButton.Title", fallback: "Início")
    }
    internal enum SaveButton {
      /// Salvar Consulta
      internal static let title = S.tr("Localizable", "Result.SaveButton.Title", fallback: "Salvar Consulta")
    }
  }
  internal enum SaveConsult {
    /// Salvar Consulta
    internal static let title = S.tr("Localizable", "SaveConsult.Title", fallback: "Salvar Consulta")
    internal enum NameTextField {
      /// Insira um nome para sua consulta
      internal static let placeHolder = S.tr("Localizable", "SaveConsult.NameTextField.PlaceHolder", fallback: "Insira um nome para sua consulta")
    }
    internal enum SaveConsultButton {
      /// Salvar
      internal static let title = S.tr("Localizable", "SaveConsult.SaveConsultButton.Title", fallback: "Salvar")
    }
  }
  internal enum TextField {
    internal enum MoneyPlaceHolder {
      /// R$ 0,00
      internal static let text = S.tr("Localizable", "TextField.MoneyPlaceHolder.Text", fallback: "R$ 0,00")
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
