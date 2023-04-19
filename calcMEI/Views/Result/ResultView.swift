//
//  ResultView.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 15/02/23.
//

import UIKit
import CalcMEI_Core

protocol ResultViewDelegate: AnyObject {
    func nextButtonPressed()
    func saveButtonPressed()
}

class ResultView: UIView {
    
    weak var delegate: ResultViewDelegate?
    
    // MARK: - Properties
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .center
        view.spacing = 20
        view.distribution = .fill
        return view
    }()
    
    // TODO: Change label names
    private lazy var receitaBrutaAnual: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var lucroApurado: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var rendimentoIsento: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var rendimentoTributável: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Buttons
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(S.Result.SaveButton.title, for: .normal)
        button.backgroundColor = A.Colors.green.color
        button.setBackgroundColor(A.Colors.background.color.withAlphaComponent(0.5), for: .highlighted)
        
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var popButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(S.Result.PopButton.title, for: .normal)
        button.backgroundColor = A.Colors.buttonBlue.color
        button.setBackgroundColor(A.Colors.background.color.withAlphaComponent(0.5), for: .highlighted)
        
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(popButtonPressed), for: .touchUpInside)
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
        addSubview(stackView)
        
        stackView.addArrangedSubview(receitaBrutaAnual)
        stackView.addArrangedSubview(lucroApurado)
        stackView.addArrangedSubview(rendimentoIsento)
        stackView.addArrangedSubview(rendimentoTributável)
        
        addSubview(popButton)
        addSubview(saveButton)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            
            // stackView
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            // popButton
            popButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -18),
            popButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            popButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            popButton.heightAnchor.constraint(equalToConstant: 45),
            
            // saveButton
            saveButton.bottomAnchor.constraint(equalTo: popButton.topAnchor, constant: -20),
            saveButton.leadingAnchor.constraint(equalTo: popButton.leadingAnchor),
            saveButton.trailingAnchor.constraint(equalTo: popButton.trailingAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 45),
        ])
    }
    
    // MARK: - Private Actions

    @objc
    private func saveButtonPressed() {
        delegate?.saveButtonPressed()
    }
    
    @objc
    private func popButtonPressed() {
        delegate?.nextButtonPressed()
    }
    
    // MARK: - Public Actions
    
    public func updateView(with count: Count) {
        receitaBrutaAnual.text = "Receita Bruta Anual: \(count.receitaBrutaAnual.currencyFormatFromDouble())"
        lucroApurado.text = "Lucro Apurado: \(count.lucroApurado.currencyFormatFromDouble())"
        rendimentoIsento.text = "Rendimento Isento: \(count.rendimentoIsento.currencyFormatFromDouble())"
        rendimentoTributável.text = "Rendimento Tributável: \(count.rendimentoTributável.currencyFormatFromDouble())"
    }
}
