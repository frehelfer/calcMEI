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
    func nextBottomButtonPressed(expenses: Double)
    func nextNavButtonPressed(expenses: Double)
}

class ExpensesView: UIView {
    
    weak var delegate: ExpensesViewDelegate?
    
    // MARK: - Properties
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [expensesFormContainer])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .center
        view.spacing = 32
        return view
    }()
    
    private lazy var expensesFormContainer: CustomFormContainer = {
        let view = CustomFormContainer(
            title: S.Expenses.ExpensesContainer.Title.text,
            description: S.Expenses.ExpensesContainer.Description.text,
            colorType: .red
        )
        view.accessibilityIdentifier = "expensesFormContainer"
        return view
    }()
    
    // Button
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(S.Expenses.NextButton.title, for: .normal)
        button.backgroundColor = A.Colors.buttonBlue.color
        button.setBackgroundColor(A.Colors.background.color.withAlphaComponent(0.5), for: .highlighted)
        
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(nextBottomButtonPressed), for: .touchUpInside)
        button.accessibilityIdentifier = "goToResultButton"
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
        backgroundColor = A.Colors.background.color
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        addSubview(stackView)
        addSubview(nextButton)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            
            // stackView
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            
            expensesFormContainer.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            expensesFormContainer.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            // nextButton
            nextButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -18),
            nextButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nextButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            nextButton.heightAnchor.constraint(equalToConstant: 45),
            
        ])
    }
    
    // MARK: - Private Actions
    private func getTextFieldData() -> Double? {
        return expensesFormContainer.getTextFieldValue()?.currencyFormattedToDouble() ?? nil
    }
    
    @objc
    private func nextBottomButtonPressed() {
        guard let data = getTextFieldData() else { return }
        self.delegate?.nextBottomButtonPressed(expenses: data)
    }
    
    // MARK: - Public Actions
    func nextNavButtonPressed() {
        guard let data = getTextFieldData() else { return }
        self.delegate?.nextNavButtonPressed(expenses: data)
    }
}
