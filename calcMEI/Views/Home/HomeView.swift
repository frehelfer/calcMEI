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
        label.text = S.Home.TitleLabel.text
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        label.textColor = A.Colors.labelSecondary.color
        label.textAlignment = .center
        label.text = S.Home.InfoLabel.text
        return label
    }()
    
    private lazy var savedConsultsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(S.Home.SavedConsultsButton.title, for: .normal)
        button.backgroundColor = A.Colors.buttonBlue.color
        button.setBackgroundColor(A.Colors.background.color.withAlphaComponent(0.5), for: .highlighted)
        
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(savedConsultsButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var newConsultButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(S.Home.NewConsultButton.title, for: .normal)
        button.backgroundColor = A.Colors.buttonBlue.color
        button.setBackgroundColor(A.Colors.background.color.withAlphaComponent(0.5), for: .highlighted)
        
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(newConsultButtonPressed), for: .touchUpInside)
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
        
        addSubview(savedConsultsButton)
        addSubview(newConsultButton)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            
            // mainStackView
            mainStackView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -130),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            // savedConsultsButton
            savedConsultsButton.bottomAnchor.constraint(equalTo: newConsultButton.topAnchor, constant: -20),
            savedConsultsButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            savedConsultsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            savedConsultsButton.heightAnchor.constraint(equalToConstant: 45),
            
            // newConsultButton
            newConsultButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -18),
            newConsultButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            newConsultButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            newConsultButton.heightAnchor.constraint(equalToConstant: 45),
        ])
    }
    
    // MARK: - Private Actions
    
    @objc
    private func newConsultButtonPressed() {
        delegate?.nextButtonPressed()
    }
    
    @objc
    private func savedConsultsButtonPressed() {
        delegate?.consultsButtonPressed()
    }
    
    // MARK: - Public Actions
}
