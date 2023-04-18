//
//  ConsultTableViewCell.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 28/03/23.
//

import UIKit
import CalcMEI_Core

class ConsultTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .leading
        view.spacing = 3
        view.distribution = .fill
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var chevronImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "chevron.right")
        image.tintColor = UIColor.systemGray2
        return image
    }()
    
    // MARK: - Initializers
    
    static let identifier = "ConsultTableViewCell"
    
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
        backgroundColor = A.Colors.background.color
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(dateLabel)
        
        contentView.addSubview(chevronImage)
    
        
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            
            // stackView
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            // chevronImage
            chevronImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            chevronImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            
        ])
    }
    
    // MARK: - Private Actions
    
    // MARK: - Public Actions
    public func setupCell(with consult: Consult?) {
        nameLabel.text = consult?.name ?? ""
        dateLabel.text = "22/22/22 implementar"
    }
    
    
}
