//
//  ResultTableViewCell.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 08/05/23.
//

import UIKit

class ResultTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [titleLabel, resultLabel, chevronImage])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.alignment = .center
        view.spacing = 3
        view.distribution = .fill
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = A.Colors.labelPrimary.color
        return label
    }()
    
    private lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = A.Colors.labelSecondary.color
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
    static let identifier = "ResultTableViewCell"
    
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
        backgroundColor = A.Colors.blue50.color
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        contentView.addSubview(stackView)
        stackView.setCustomSpacing(10, after: resultLabel)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            
            // stackView
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -13),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            chevronImage.heightAnchor.constraint(equalToConstant: 8),
            chevronImage.widthAnchor.constraint(equalToConstant: 8),
            
        ])
    }
    
    // MARK: - Private Actions
    
    // MARK: - Public Actions
    public func setupCell(data: ResultViewModel.NestedResult?) {
        titleLabel.text = data?.title
        resultLabel.text = data?.result
        
        if data?.resultColor != nil {
            resultLabel.textColor = data?.resultColor
        }
    }
}
