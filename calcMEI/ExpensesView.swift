//
//  ExpensesView.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 15/02/23.
//

import UIKit

protocol ExpensesViewDelegate: AnyObject {
    func nextButtonPressed()
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
    
    // MARK: - Service properties
    private lazy var expensesStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 13
        
        stackView.backgroundColor = .theme.greenBackground2
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 13, left: 13, bottom: 13, right: 13)
        
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
        label.textColor = .theme.label1
        label.text = "Prestação de Serviços"
        label.addCharacterSpacing(kernValue: 1.05)
        return label
    }()
    
    private lazy var expensesTextField: UITextField = {
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
    
    // Button
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Começar", for: .normal)
        button.backgroundColor = .systemBlue
        
        
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        return button
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
        backgroundColor = .theme.mainBackground
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
            
            // nextButton
            nextButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            nextButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nextButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            nextButton.heightAnchor.constraint(equalToConstant: 45),
        ])
    }
    
    // MARK: - Private Actions
    
    @objc
    private func nextButtonPressed() {
        self.delegate?.nextButtonPressed()
    }
    
    // MARK: - Public Actions
}
