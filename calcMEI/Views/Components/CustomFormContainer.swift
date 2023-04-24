//
//  ContainerView.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 22/04/23.
//

import UIKit
import CurrencyUITextFieldDelegate
import CurrencyFormatter

class CustomFormContainer: UIView {
    
    // MARK: - Properties
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [labelView, textFieldView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical

        stackView.layer.cornerRadius = cornerRadius
        stackView.layer.borderWidth = 1

        stackView.layer.shadowColor = A.Colors.shadowMedium.color.cgColor
        stackView.layer.shadowRadius = 5
        stackView.layer.shadowOffset = CGSize(width: 5, height: 5)
        stackView.layer.shadowOpacity = 0.5
        return stackView
    }()
    
    private lazy var labelView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.modifyCornerRadius(corner: .top, radius: cornerRadius)
        return view
    }()
    
    private lazy var textFieldView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.modifyCornerRadius(corner: .bottom, radius: cornerRadius)
        return view
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = A.Colors.labelPrimary.color
        return label
    }()
    
    private let categoryTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = S.TextField.MoneyPlaceHolder.text
        textField.font = UIFont.monospacedSystemFont(ofSize: 16, weight: .regular)
        textField.textColor = A.Colors.labelPrimary.color
        textField.keyboardType = .numberPad
        textField.returnKeyType = .next
        textField.textAlignment = .center
        return textField
    }()
    
    // MARK: - Init
    private var textFieldDelegate: CurrencyUITextFieldDelegate!
    
    var cornerRadius: CGFloat = 18
    
    init(text: String, colorType: ColorType) {
        super.init(frame: .zero)
        
        self.categoryLabel.text = text
        
        switch colorType {
        case .green:
            stackView.layer.borderColor = A.Colors.green.color.withAlphaComponent(0.1).cgColor
            labelView.backgroundColor = A.Colors.green25.color
            textFieldView.backgroundColor = A.Colors.green50.color
            
        case .red:
            self.stackView.layer.borderColor = A.Colors.red.color.withAlphaComponent(0.1).cgColor
            labelView.backgroundColor = A.Colors.red25.color
            textFieldView.backgroundColor = A.Colors.red50.color
            
        }
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetupView
    private func setupView() {
        configureSubviews()
        configureConstraints()
        setupTextFieldWithCurrencyDelegate()
    }
    
    private func configureSubviews() {
        addSubview(stackView)
        
        labelView.addSubview(categoryLabel)
        textFieldView.addSubview(categoryTextField)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),

            labelView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            labelView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),

            textFieldView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            textFieldView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),

            categoryLabel.topAnchor.constraint(equalTo: labelView.topAnchor, constant: 20),
            categoryLabel.bottomAnchor.constraint(equalTo: labelView.bottomAnchor, constant: -13),
            categoryLabel.leadingAnchor.constraint(equalTo: labelView.leadingAnchor, constant: 15),
            categoryLabel.trailingAnchor.constraint(equalTo: labelView.trailingAnchor, constant: -15),

            categoryTextField.topAnchor.constraint(equalTo: textFieldView.topAnchor, constant: 13),
            categoryTextField.bottomAnchor.constraint(equalTo: textFieldView.bottomAnchor, constant: -13),
            categoryTextField.leadingAnchor.constraint(equalTo: textFieldView.leadingAnchor),
            categoryTextField.trailingAnchor.constraint(equalTo: textFieldView.trailingAnchor, constant: -10),
            
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
//        textFieldDelegate.passthroughDelegate = self

        categoryTextField.delegate = textFieldDelegate
    }
    
    // MARK: - Public Actions
    func getTextFieldValue() -> String? {
        guard let value = categoryTextField.text else { return nil }
        
        return value
    }
    
    enum ColorType {
        case green
        case red
    }
}
