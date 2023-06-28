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
    func nextNavButtonSelected(incomeData: IncomeViewModel.IncomeData)
}

class IncomeView: UIView {
    
    weak var delegate: IncomeViewDelegate?
    
    // MARK: - Properties
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [servicesFormContainer, commerceFormContainer, transportFormContainer])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 32
        return stackView
    }()
    
    private lazy var servicesFormContainer: CustomFormContainer = {
        let view = CustomFormContainer(
            title: S.Income.ServicesLabel.text,
            colorType: .green
        )
        return view
    }()
    
    private lazy var commerceFormContainer: CustomFormContainer = {
        let view = CustomFormContainer(
            title: S.Income.CommerceLabel.text,
            colorType: .green
        )
        return view
    }()
    
    private lazy var transportFormContainer: CustomFormContainer = {
        let view = CustomFormContainer(
            title: S.Income.TransportLabel.text,
            colorType: .green
        )
        return view
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
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        addSubview(nextButton)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            
            // scrollView
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -10),
            scrollView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
            
            // stackView
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 90),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            servicesFormContainer.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 30),
            servicesFormContainer.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -30),
            
            commerceFormContainer.leadingAnchor.constraint(equalTo: servicesFormContainer.leadingAnchor),
            commerceFormContainer.trailingAnchor.constraint(equalTo: servicesFormContainer.trailingAnchor),
            
            transportFormContainer.leadingAnchor.constraint(equalTo: servicesFormContainer.leadingAnchor),
            transportFormContainer.trailingAnchor.constraint(equalTo: servicesFormContainer.trailingAnchor),
            
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
        guard let data = textFieldData() else { return }
        self.delegate?.nextButtonPressed(incomeData: data)
    }
    
    private func textFieldData() -> IncomeViewModel.IncomeData? {
        guard
            let servicesText = servicesFormContainer.getTextFieldValue(),
            let commerceText = commerceFormContainer.getTextFieldValue(),
            let transportText = transportFormContainer.getTextFieldValue()
        else { return nil }

        let incomeData = IncomeViewModel.IncomeData(
            inServiceProvision: servicesText.currencyFormattedToDouble(),
            inCommerce: commerceText.currencyFormattedToDouble(),
            inPassengerTransport: transportText.currencyFormattedToDouble()
        )
        
        return incomeData
    }
    
    // MARK: - Public Actions
    func nextNavButtonPressed() {
        guard let data = textFieldData() else { return }
        self.delegate?.nextNavButtonSelected(incomeData: data)
    }
    
    func updateScrollView(contentInsets: UIEdgeInsets) {
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
}
