//
//  ContainerView.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 22/04/23.
//

import UIKit
import CurrencyUITextFieldDelegate
import CurrencyFormatter

class ContainerView: UIView {
    
    // MARK: - Properties
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        
//        stackView.layer.borderColor = A.Colors.green.color.withAlphaComponent(0.1).cgColor
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
//        view.backgroundColor = A.Colors.green25.color
        view.modifyCornerRadius(corner: .top, radius: cornerRadius)
        return view
    }()
    
    private lazy var textFieldView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = A.Colors.green50.color
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
//        label.text = S.Income.ServicesLabel.text
        return label
    }()
    
    private lazy var categoryTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = S.TextField.MoneyPlaceHolder.text
        textField.font = UIFont.monospacedSystemFont(ofSize: 16, weight: .regular)
        textField.textColor = A.Colors.labelPrimary.color
        textField.keyboardType = .numberPad
        textField.returnKeyType = .next
        textField.textAlignment = .center
        textField.backgroundColor = .red
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
        
//        self.isUserInteractionEnabled = true
        
        setupView()
        
//        setupTapGestureRecognizer()
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
        
        // services
        stackView.addArrangedSubview(labelView)
        stackView.addArrangedSubview(textFieldView)
        
        labelView.addSubview(categoryLabel)
        textFieldView.addSubview(categoryTextField)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            labelView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            labelView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            textFieldView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            textFieldView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            categoryLabel.topAnchor.constraint(equalTo: labelView.topAnchor, constant: 20),
            categoryLabel.bottomAnchor.constraint(equalTo: labelView.bottomAnchor, constant: -13),
            categoryLabel.leadingAnchor.constraint(equalTo: labelView.leadingAnchor, constant: 15),
            categoryLabel.trailingAnchor.constraint(equalTo: labelView.trailingAnchor, constant: -15),
            categoryLabel.centerXAnchor.constraint(equalTo: labelView.centerXAnchor),
            
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
        textFieldDelegate.passthroughDelegate = self
        
        categoryTextField.delegate = textFieldDelegate
    }
    
//    private func setupTapGestureRecognizer() {
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
//        self.addGestureRecognizer(tapGesture)
//    }
//
//    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
//        // When the custom view is tapped, make the UITextField the first responder
//        self.categoryTextField.becomeFirstResponder()
//    }
    
    // MARK: - Public Actions
    func getTextFieldValue() -> Double? {
        guard let value = categoryTextField.text else { return nil }
        
        return Double(value)
    }
    
    enum ColorType {
        case green
        case red
    }
}

extension ContainerView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
//        let unformattedValue = textFieldDelegate
//            .formatter
//            .unformatted(
//                string: textField.text ?? "0"
//            ) ?? "0"
//        label.text = "Formatted value: \(textField.text ?? "0")"
    }
}


