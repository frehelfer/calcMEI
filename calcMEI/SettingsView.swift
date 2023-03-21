//
//  SettingsView.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 20/03/23.
//

import UIKit

protocol SettingsViewDelegate: AnyObject {
    
}

class SettingsView: UIView {
    
    weak var delegate: SettingsViewDelegate?
    
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
    
    private lazy var appVersionInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .theme.label2
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
        backgroundColor = .theme.mainBackground
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        addSubview(appVersionInfoLabel)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            
            // appVersionInfoLabel
            appVersionInfoLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            appVersionInfoLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
        ])
    }
    
    // MARK: - Private Actions
    
    // MARK: - Public Actions
    public func updateView(with appVersion: String?) {
        self.appVersionInfoLabel.text = appVersion
    }
}
