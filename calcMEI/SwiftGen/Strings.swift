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
    internal enum EmptyTitleLabel {
      /// Nenhuma consulta salva
      internal static let text = S.tr("Localizable", "Consults.EmptyTitleLabel.text", fallback: "Nenhuma consulta salva")
    }
    internal enum NewConsultButton {
      /// Comece aqui
      internal static let title = S.tr("Localizable", "Consults.NewConsultButton.title", fallback: "Comece aqui")
    }
  }
  internal enum Detail {
    internal enum Alert {
      /// Você tem certeza de que deseja excluir este item? Essa ação não pode ser desfeita.
      internal static let message = S.tr("Localizable", "Detail.Alert.Message", fallback: "Você tem certeza de que deseja excluir este item? Essa ação não pode ser desfeita.")
      /// Confirmação de exclusão
      internal static let title = S.tr("Localizable", "Detail.Alert.Title", fallback: "Confirmação de exclusão")
    }
  }
  internal enum Expenses {
    /// Despesas Anuais
    internal static let title = S.tr("Localizable", "Expenses.Title", fallback: "Despesas Anuais")
    internal enum ExpensesContainer {
      internal enum Description {
        /// Essas despesas podem ser deduzidas do lucro da empresa, reduzindo assim a base de cálculo do imposto. Para isso, é necessário que as despesas estejam comprovadas por meio de nota fiscal e/ou recibo.
        /// 
        ///  As duas despesas mais comuns são o Pró-labore e o DAS, pago mensalmente por todo dono de uma MEI.
        internal static let text = S.tr("Localizable", "Expenses.ExpensesContainer.Description.Text", fallback: "Essas despesas podem ser deduzidas do lucro da empresa, reduzindo assim a base de cálculo do imposto. Para isso, é necessário que as despesas estejam comprovadas por meio de nota fiscal e/ou recibo.\n\n As duas despesas mais comuns são o Pró-labore e o DAS, pago mensalmente por todo dono de uma MEI.")
      }
      internal enum Title {
        /// Pró-labore, DAS, Mercadorias, Aluguel, Água, Luz e Tel.
        internal static let text = S.tr("Localizable", "Expenses.ExpensesContainer.Title.Text", fallback: "Pró-labore, DAS, Mercadorias, Aluguel, Água, Luz e Tel.")
      }
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
  internal enum Settings {
    /// Configurações
    internal static let title = S.tr("Localizable", "Settings.Title", fallback: "Configurações")
  }
  internal enum TextField {
    internal enum MoneyPlaceHolder {
      /// R$ 0,00
      internal static let text = S.tr("Localizable", "TextField.MoneyPlaceHolder.Text", fallback: "R$ 0,00")
    }
  }
  internal enum UIAlertController {
    internal enum Cancel {
      /// Cancelar
      internal static let text = S.tr("Localizable", "UIAlertController.Cancel.Text", fallback: "Cancelar")
    }
    internal enum Delete {
      /// Excluir
      internal static let text = S.tr("Localizable", "UIAlertController.Delete.Text", fallback: "Excluir")
    }
    internal enum Ok {
      /// Ok
      internal static let text = S.tr("Localizable", "UIAlertController.Ok.Text", fallback: "Ok")
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
