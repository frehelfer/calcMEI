//
//  ExpensesView.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 15/02/23.
//

import UIKit
import CurrencyUITextFieldDelegate
import CurrencyFormatter

protocol ExpensesViewDelegate: AnyObject {
    func nextButtonPressed(expenses: Double)
}

class ExpensesView: UIView {
    
    weak var delegate: ExpensesViewDelegate?
    
    // MARK: - Properties
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .center
        view.spacing = 10
        view.distribution = .fill
        return view
    }()
    
    // MARK: - Expenses properties
    private lazy var expensesStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 13
        
        stackView.backgroundColor = A.Colors.red50.color
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
    
    private lazy var expensesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = A.Colors.labelPrimary.color
        label.text = "Pró-labore, DAS, Mercadorias, Aluguel, Água, Luz e Tel."
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var expensesTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "R$ 0,00"
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.textColor = A.Colors.labelPrimary.color
        textField.autocorrectionType = .no
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        textField.returnKeyType = .next
        
        return textField
    }()
    
    // Button
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Resultado", for: .normal)
        button.backgroundColor = A.Colors.buttonBlue.color
        button.setBackgroundColor(A.Colors.background.color.withAlphaComponent(0.5), for: .highlighted)
        
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
        backgroundColor = A.Colors.background.color
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        addSubview(stackView)
        
        stackView.addArrangedSubview(expensesStack)
        
        expensesStack.addArrangedSubview(expensesLabel)
        expensesStack.addArrangedSubview(expensesTextField)
        
        addSubview(nextButton)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            
            // stackView
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            // expensesStack
            expensesStack.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            expensesStack.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            expensesTextField.widthAnchor.constraint(equalToConstant: 200),
            
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
        
        expensesTextField.delegate = textFieldDelegate
    }
    
    // MARK: - Private Actions
    
    @objc
    private func nextButtonPressed() {
        guard
            let expenses = expensesTextField.text
        else { return }
        
        self.delegate?.nextButtonPressed(expenses: expenses.currencyFormattedToDouble())
    }
    
    // MARK: - Public Actions
    
}

extension ExpensesView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
//        let unformattedValue = textFieldDelegate
//            .formatter
//            .unformatted(
//                string: textField.text ?? "0"
//            ) ?? "0"
//        label.text = "Formatted value: \(textField.text ?? "0")"
    }
}
