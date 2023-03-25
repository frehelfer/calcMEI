//
//  SaveConsultView.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 23/03/23.
//

import UIKit

protocol SaveConsultViewDelegate: AnyObject {
    
}

class SaveConsultView: UIView {
    
    weak var delegate: SaveConsultViewDelegate?
    
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
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sua consulta"
        return label
    }()
    
    // Buttons
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.backgroundColor = .systemGray
        button.setBackgroundColor(.theme.buttonHighLight, for: .highlighted)
        
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
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
//        addSubview(backButton)
//        addSubview(stackView)
        
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            
            // backButton
//            backButton.topAnchor.constraint(equalTo: topAnchor, constant: 20),
//            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
//            backButton.heightAnchor.constraint(equalToConstant: 35),
//            backButton.widthAnchor.constraint(equalToConstant: 35),
//            
//            // stackView
//            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
//            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
//            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }
    
    // MARK: - Private Actions
    
    @objc
    private func backButtonPressed() {
    }
    
    // MARK: - Public Actions
    
}
