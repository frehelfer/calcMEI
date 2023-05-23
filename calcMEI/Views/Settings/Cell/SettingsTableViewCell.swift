//
//  SettingsTableViewCell.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 10/05/23.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [imageBackground, titleLabel, chevronImage])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.alignment = .center
        view.spacing = 3
        view.distribution = .fill
        return view
    }()
    
    private lazy var imageBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 7
        return view
    }()
    
    private lazy var iconImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = .white
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = A.Colors.labelPrimary.color
        return label
    }()
    
    private lazy var chevronImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "chevron.right")
        image.contentMode = .scaleAspectFill
        image.tintColor = A.Colors.labelSecondary.color.withAlphaComponent(0.7)
        return image
    }()
    
    // MARK: - Initializers
    static let identifier = "SettingsTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetupCell
    private func setupView() {
        selectionStyle = .none
        backgroundColor = .systemGray5
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        contentView.addSubview(stackView)
        
        imageBackground.addSubview(iconImageView)
        stackView.setCustomSpacing(12, after: imageBackground)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            
            // stackView
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            imageBackground.heightAnchor.constraint(equalToConstant: 32),
            imageBackground.widthAnchor.constraint(equalToConstant: 32),
            
            iconImageView.heightAnchor.constraint(equalToConstant: 20),
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            iconImageView.centerYAnchor.constraint(equalTo: imageBackground.centerYAnchor),
            iconImageView.centerXAnchor.constraint(equalTo: imageBackground.centerXAnchor),
            
            chevronImage.heightAnchor.constraint(equalToConstant: 10),
            chevronImage.widthAnchor.constraint(equalToConstant: 10),
            
        ])
    }
    
    // MARK: - Public Actions
    public func setupCell(with data: SettingsViewModel.SettingsDetail?) {
        guard let data else { return }
        titleLabel.text = data.title
        imageBackground.backgroundColor = data.color
        iconImageView.image = UIImage(systemName: data.icon)
    }
}

