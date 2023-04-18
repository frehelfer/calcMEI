//
//  HomeView.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 15/02/23.
//

import UIKit

protocol HomeViewDelegate: AnyObject {
    func nextButtonPressed()
    func consultsButtonPressed()
}

class HomeView: UIView {
    
    weak var delegate: HomeViewDelegate?
    
    // MARK: - Properties

    private lazy var mainStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .center
        view.spacing = 30
        view.distribution = .fill
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textColor = A.Colors.labelPrimary.color
        label.textAlignment = .center
        label.text = "Calculadora Declaração \n IRPF - MEI"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        label.textColor = A.Colors.labelSecondary.color
        label.textAlignment = .center
        label.text = "Ano-Calendário de 2022 - Exercício de 2023"
        return label
    }()
    
    private lazy var consultsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Consultas salvas", for: .normal)
        button.backgroundColor = A.Colors.buttonBlue.color
        button.setBackgroundColor(A.Colors.background.color.withAlphaComponent(0.5), for: .highlighted)
        
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(consultsButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Nova consulta", for: .normal)
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
        addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(infoLabel)
        
        addSubview(consultsButton)
        addSubview(nextButton)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            
            // mainStackView
            mainStackView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -130),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            // nextButton
            consultsButton.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -20),
            consultsButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            consultsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            consultsButton.heightAnchor.constraint(equalToConstant: 45),
            
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
        delegate?.nextButtonPressed()
    }
    
    @objc
    private func consultsButtonPressed() {
        delegate?.consultsButtonPressed()
    }
    
    // MARK: - Public Actions
}
