//
//  SaveConsultView.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 23/03/23.
//

import UIKit

class ItemDetailView: UIView {
    
    // MARK: - Properties
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .justified
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = A.Colors.labelPrimary.color
        label.numberOfLines = 0
        return label
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
        addSubview(descriptionLabel)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            
            // descriptionLabel
            descriptionLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 25),
            descriptionLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
        ])
    }
    
    // MARK: - Private Actions
    
    
    // MARK: - Public Actions
    func updateView(with data: ResultViewModel.ResultItem) {
        descriptionLabel.text = data.description
    }
    
}
