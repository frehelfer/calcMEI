//
//  IncomeView.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 15/02/23.
//

import UIKit
import CurrencyUITextFieldDelegate
import CurrencyFormatter

protocol IncomeViewDelegate: AnyObject {
    func nextButtonPressed()
}

class IncomeView: UIView {
    
    weak var delegate: IncomeViewDelegate?
    
    // MARK: - Main Properties
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 35

        return stackView
    }()
    
    // MARK: - Service properties
    private lazy var servicesStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 13
        
        stackView.backgroundColor = .theme.greenBackground2
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 15, left: 15, bottom: 13, right: 13)
        
        stackView.layer.borderColor = UIColor.systemGray.withAlphaComponent(0.2).cgColor
        stackView.layer.cornerRadius = 10
        stackView.layer.borderWidth = 1
        
        stackView.layer.shadowColor = UIColor.gray.withAlphaComponent(0.4).cgColor
        stackView.layer.shadowRadius = 5
        stackView.layer.shadowOffset = CGSize(width: 5, height: 5)
        stackView.layer.shadowOpacity = 0.5
        return stackView
    }()
    
    private lazy var servicesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .theme.label1
        label.text = "Prestação de Serviços"
        return label
    }()
    
    private lazy var servicesTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "R$ 0,00"
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.textColor = .theme.label1
        textField.autocorrectionType = .no
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        textField.returnKeyType = .next
        
        return textField
    }()
    
    // // MARK: - Commerce properties
    private lazy var commerceStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 13
        
        stackView.backgroundColor = .theme.greenBackground2
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 15, left: 15, bottom: 13, right: 13)
        
        stackView.layer.borderColor = UIColor.systemGray.withAlphaComponent(0.2).cgColor
        stackView.layer.cornerRadius = 10
        stackView.layer.borderWidth = 1
        
        stackView.layer.shadowColor = UIColor.gray.withAlphaComponent(0.4).cgColor
        stackView.layer.shadowRadius = 5
        stackView.layer.shadowOffset = CGSize(width: 5, height: 5)
        stackView.layer.shadowOpacity = 0.5
        return stackView
    }()
    
    private lazy var commerceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .theme.label1
        label.text = "Comércio, Indústria e \n Transporte de Cargas"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var commerceTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "R$ 0,00"
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.textColor = .theme.label1
        textField.autocorrectionType = .no
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        textField.returnKeyType = .next
        
        return textField
    }()
    
    // // MARK: - Transport properties
    private lazy var transportStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 13
        
        stackView.backgroundColor = .theme.greenBackground2
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 15, left: 15, bottom: 13, right: 13)
        
        stackView.layer.borderColor = UIColor.systemGray.withAlphaComponent(0.2).cgColor
        stackView.layer.cornerRadius = 10
        stackView.layer.borderWidth = 1
        
        stackView.layer.shadowColor = UIColor.gray.withAlphaComponent(0.4).cgColor
        stackView.layer.shadowRadius = 5
        stackView.layer.shadowOffset = CGSize(width: 5, height: 5)
        stackView.layer.shadowOpacity = 0.5
        return stackView
    }()
    
    private lazy var transportLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .theme.label1
        label.text = "Transporte de Passageiros"
        return label
    }()
    
    private lazy var transportTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "R$ 0,00"
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.textColor = .theme.label1
        textField.autocorrectionType = .no
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        textField.returnKeyType = .next
        
        return textField
    }()
    
    
    // nextButton
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Próximo", for: .normal)
        button.backgroundColor = .systemBlue
        
        
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private var textFieldDelegate: CurrencyUITextFieldDelegate!
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupTextFieldWithCurrencyDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetupView
    
    private func setupView() {
        backgroundColor = .theme.mainBackground
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        addSubview(stackView)
        
        stackView.addArrangedSubview(servicesStack)
        stackView.addArrangedSubview(commerceStack)
        stackView.addArrangedSubview(transportStack)
        
        servicesStack.addArrangedSubview(servicesLabel)
        servicesStack.addArrangedSubview(servicesTextField)

        commerceStack.addArrangedSubview(commerceLabel)
        commerceStack.addArrangedSubview(commerceTextField)
        
        transportStack.addArrangedSubview(transportLabel)
        transportStack.addArrangedSubview(transportTextField)
        
        addSubview(nextButton)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            
            // stackView
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            // servicesStack
            servicesStack.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            servicesStack.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            servicesTextField.widthAnchor.constraint(equalToConstant: 200),
            
            // commerceStack
            commerceStack.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            commerceStack.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            commerceTextField.widthAnchor.constraint(equalToConstant: 200),
            
            // transportStack
            transportStack.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            transportStack.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            transportTextField.widthAnchor.constraint(equalToConstant: 200),
            
            // nextButton
            nextButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -18),
            nextButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nextButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            nextButton.heightAnchor.constraint(equalToConstant: 45),
        ])
    }
    
    private func setupTextFieldWithCurrencyDelegate() {
        let currencyFormatter = CurrencyFormatter {
            $0.maxValue = 100000000
            $0.currency = .brazilianReal
            $0.locale = CurrencyLocale.portugueseBrazil
            $0.hasDecimals = true
        }
        
        textFieldDelegate = CurrencyUITextFieldDelegate(formatter: currencyFormatter)
        textFieldDelegate.clearsWhenValueIsZero = true
        textFieldDelegate.passthroughDelegate = self
        
        servicesTextField.delegate = textFieldDelegate
        commerceTextField.delegate = textFieldDelegate
        transportTextField.delegate = textFieldDelegate
    }
    
    // MARK: - Private Actions
    
    @objc
    private func nextButtonPressed() {
        self.delegate?.nextButtonPressed()
    }
    
    // MARK: - Public Actions

}

extension IncomeView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
//        let unformattedValue = textFieldDelegate
//            .formatter
//            .unformatted(
//                string: textField.text ?? "0"
//            ) ?? "0"
//        label.text = "Formatted value: \(textField.text ?? "0")"
    }
}
