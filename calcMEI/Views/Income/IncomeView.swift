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
    func nextButtonPressed(incomeData: IncomeViewModel.IncomeData)
}

class IncomeView: UIView {
    
    weak var delegate: IncomeViewDelegate?
    
    // MARK: - Properties
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [infoLabel, servicesFormContainer, commerceFormContainer, transportFormContainer])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 32
        return stackView
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = A.Colors.labelPrimary.color.withAlphaComponent(0.9)
        label.text = S.Income.InfoLabel.text
        return label
    }()
    
    // MARK: - Service properties
    private lazy var servicesFormContainer: CustomFormContainer = {
        CustomFormContainer(text: S.Income.ServicesLabel.text, colorType: .green)
    }()
    
    // // MARK: - Commerce properties
    private lazy var commerceFormContainer: CustomFormContainer = {
        CustomFormContainer(text: S.Income.CommerceLabel.text, colorType: .green)
    }()
    
    // // MARK: - Transport properties
    private lazy var transportFormContainer: CustomFormContainer = {
        CustomFormContainer(text: S.Income.TransportLabel.text, colorType: .green)
    }()
    
    // nextButton
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(S.Income.NextButton.title, for: .normal)
        button.backgroundColor = A.Colors.buttonBlue.color
        button.setBackgroundColor(A.Colors.background.color.withAlphaComponent(0.5), for: .highlighted)
        
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
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            
            servicesFormContainer.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            servicesFormContainer.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            commerceFormContainer.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            commerceFormContainer.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            transportFormContainer.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            transportFormContainer.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            // nextButton
            nextButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -18),
            nextButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nextButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            nextButton.heightAnchor.constraint(equalToConstant: 45),
        ])
    }
    
    // MARK: - Private Actions
    @objc
    private func nextButtonPressed() {
        guard
            let servicesText = servicesFormContainer.getTextFieldValue(),
            let commerceText = commerceFormContainer.getTextFieldValue(),
            let transportText = transportFormContainer.getTextFieldValue()
        else { return }

        let incomeData = IncomeViewModel.IncomeData(
            inServiceProvision: servicesText.currencyFormattedToDouble(),
            inCommerce: commerceText.currencyFormattedToDouble(),
            inPassengerTransport: transportText.currencyFormattedToDouble()
        )
        
        self.delegate?.nextButtonPressed(incomeData: incomeData)
    }
    
    // MARK: - Public Actions
}
