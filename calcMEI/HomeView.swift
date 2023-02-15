//
//  HomeView.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 15/02/23.
//

import UIKit

protocol HomeViewDelegate: AnyObject {
    func nextButtonPressed()
}

class HomeView: UIView {
    
    weak var delegate: HomeViewDelegate?
    
    // MARK: - Properties

    private lazy var mainStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .center
        view.spacing = 10
        view.distribution = .fill
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textColor = .label.withAlphaComponent(0.8)
        label.textAlignment = .center
        label.text = "Calculadora Declaração \n IRPF - MEI"
        label.numberOfLines = 0
        return label
    }()
    
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
        backgroundColor = .systemBackground
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(titleLabel)
        
        addSubview(nextButton)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            
            // mainStackView
            mainStackView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -100),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
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
