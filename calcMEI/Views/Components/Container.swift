//
//  Container.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 21/04/23.
//

import UIKit

import UIKit

class CustomContainer: UIView {
    
    private let cornerRadius: CGFloat = 18
    
    // MARK: - Properties
    private lazy var servicesStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        
        stackView.layer.borderColor = A.Colors.green.color.withAlphaComponent(0.1).cgColor
        stackView.layer.cornerRadius = cornerRadius
        stackView.layer.borderWidth = 1
        
        stackView.layer.shadowColor = A.Colors.shadowMedium.color.cgColor
        stackView.layer.shadowRadius = 5
        stackView.layer.shadowOffset = CGSize(width: 5, height: 5)
        stackView.layer.shadowOpacity = 0.5
        return stackView
    }()
    
    private lazy var servicesLabelView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = A.Colors.green25.color
        view.modifyCornerRadius(corner: .top, radius: cornerRadius)
        return view
    }()
    
    private lazy var servicesTextFieldView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = A.Colors.green50.color
        view.modifyCornerRadius(corner: .bottom, radius: cornerRadius)
        return view
    }()
    
    private lazy var servicesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = A.Colors.labelPrimary.color
        label.text = S.Income.ServicesLabel.text
        return label
    }()
    
    private lazy var servicesTextField: UITextField = {
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
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetupView
    
    private func setupView() {
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        addSubview(servicesStack)
        
        servicesStack.addArrangedSubview(servicesLabelView)
        servicesStack.addArrangedSubview(servicesTextFieldView)
        
        servicesLabelView.addSubview(servicesLabel)
        servicesTextFieldView.addSubview(servicesTextField)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            
            servicesStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            servicesStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            servicesLabelView.leadingAnchor.constraint(equalTo: servicesStack.leadingAnchor),
            servicesLabelView.trailingAnchor.constraint(equalTo: servicesStack.trailingAnchor),
            
            servicesTextFieldView.leadingAnchor.constraint(equalTo: servicesStack.leadingAnchor),
            servicesTextFieldView.trailingAnchor.constraint(equalTo: servicesStack.trailingAnchor),
            
            servicesLabel.topAnchor.constraint(equalTo: servicesLabelView.topAnchor, constant: 20),
            servicesLabel.bottomAnchor.constraint(equalTo: servicesLabelView.bottomAnchor, constant: -13),
            servicesLabel.centerXAnchor.constraint(equalTo: servicesLabelView.centerXAnchor),
            
            servicesTextField.topAnchor.constraint(equalTo: servicesTextFieldView.topAnchor, constant: 13),
            servicesTextField.bottomAnchor.constraint(equalTo: servicesTextFieldView.bottomAnchor, constant: -13),
            servicesTextField.leadingAnchor.constraint(equalTo: servicesTextFieldView.leadingAnchor),
            servicesTextField.trailingAnchor.constraint(equalTo: servicesTextFieldView.trailingAnchor, constant: -10),
            
        ])
    }
    
    // MARK: - Private Actions
    
    // MARK: - Public Actions
    
}
