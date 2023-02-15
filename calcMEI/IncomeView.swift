//
//  IncomeView.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 15/02/23.
//

import UIKit

class IncomeView: UIView {
    
    // MARK: - Clousures
    
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
    
    // Services
    
    private lazy var servicesStack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .center
        view.spacing = 10
        view.distribution = .fill
        return view
    }()
    
    private lazy var servicesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textColor = .label
        label.text = "Prestação de Serviços"
        return label
    }()
    
    private lazy var servicesTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.textColor = .label
        textField.placeholder = "Insira o valor recebido"
        
        textField.keyboardType = .numberPad
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
        backgroundColor = .red
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        addSubview(servicesStack)
        
        servicesStack.addArrangedSubview(servicesLabel)
        servicesStack.addArrangedSubview(servicesTextField)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            servicesStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            servicesStack.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    // MARK: - Actions
    
}
