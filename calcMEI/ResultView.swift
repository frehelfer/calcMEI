//
//  ResultView.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 15/02/23.
//

import UIKit

protocol ResultViewDelegate: AnyObject {
    
}

class ResultView: UIView {
    
    weak var delegate: ResultViewDelegate?
    
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
        backgroundColor = .systemBlue
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            
        ])
    }
    
    // MARK: - Private Actions
    
    // MARK: - Public Actions
}
