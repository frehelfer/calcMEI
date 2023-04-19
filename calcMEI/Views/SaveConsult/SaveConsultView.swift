//
//  SaveConsultView.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 23/03/23.
//

import UIKit
import CalcMEI_Core

protocol SaveConsultViewDelegate: AnyObject {
    func saveButtonPressed(with name: String)
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
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = S.SaveConsult.NameTextField.placeHolder
        textField.returnKeyType = .done
        textField.keyboardType = .default
        textField.backgroundColor = .systemGray5
        textField.layer.cornerRadius = 10
        textField.layer.shadowColor = UIColor.gray.withAlphaComponent(0.4).cgColor
        textField.layer.shadowRadius = 5
        textField.layer.shadowOffset = CGSize(width: 5, height: 5)
        textField.layer.shadowOpacity = 0.5
        textField.setLeftPaddingPoints(11)
        textField.delegate = self
        return textField
    }()
    
    private lazy var inServiceProvision: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var inCommerce: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var inPassengerTransport: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var outExpenses: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
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
    
    
    
    private lazy var hasToDeclare: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    // Buttons
    private lazy var saveConsultButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(S.SaveConsult.SaveConsultButton.title, for: .normal)
        button.backgroundColor = A.Colors.green.color
        button.setBackgroundColor(A.Colors.background.color.withAlphaComponent(0.5), for: .highlighted)
        
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
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
        
        stackView.addArrangedSubview(nameTextField)
        
        stackView.addArrangedSubview(inServiceProvision)
        stackView.addArrangedSubview(inCommerce)
        stackView.addArrangedSubview(inPassengerTransport)
        
        stackView.addArrangedSubview(outExpenses)
        
        stackView.addArrangedSubview(receitaBrutaAnual)
        stackView.addArrangedSubview(lucroApurado)
        stackView.addArrangedSubview(rendimentoIsento)
        stackView.addArrangedSubview(rendimentoTributável)
        
        stackView.addArrangedSubview(hasToDeclare)
        
        addSubview(saveConsultButton)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            
            // stackView
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            // nameTextField
            nameTextField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            nameTextField.heightAnchor.constraint(equalToConstant: 42),
            
            // saveConsultButton
            saveConsultButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -18),
            saveConsultButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            saveConsultButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            saveConsultButton.heightAnchor.constraint(equalToConstant: 45),
            
        ])
    }
    
    // MARK: - Private Actions
    @objc
    private func saveButtonPressed() {
        print(#function)
        guard
            let name = nameTextField.text
        else { return }
        
        delegate?.saveButtonPressed(with: name)
        
    }
    
    // MARK: - Public Actions
    public func updateView(with count: Count) {
        inServiceProvision.text = "Prestação de Serviços: \(count.inServiceProvision.currencyFormatFromDouble())"
        inCommerce.text = "Comércio: \(count.inCommerce.currencyFormatFromDouble())"
        inPassengerTransport.text = "Transporte de Passageiros: \(count.inPassengerTransport.currencyFormatFromDouble())"
        
        outExpenses.text = "Despesas Anuais: \(count.outExpenses.currencyFormatFromDouble())"
        
        receitaBrutaAnual.text = "Receita Bruta Anual: \(count.receitaBrutaAnual.currencyFormatFromDouble())"
        lucroApurado.text = "Lucro Apurado: \(count.lucroApurado.currencyFormatFromDouble())"
        rendimentoIsento.text = "Rendimento Isento: \(count.rendimentoIsento.currencyFormatFromDouble())"
        rendimentoTributável.text = "Rendimento Tributável: \(count.rendimentoTributável.currencyFormatFromDouble())"
        
        hasToDeclare.text = hasToDeclareString(count.hasToDeclare)
        
        func hasToDeclareString(_ hasToDeclare: Bool) -> String {
            hasToDeclare ? "Precisa Declarar: Sim" : "Precisa Declarar: Não"
        }
    }
    
}

extension SaveConsultView: UITextFieldDelegate {
    
    
    
}
