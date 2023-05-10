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
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ResultTableViewCell.self, forCellReuseIdentifier: ResultTableViewCell.identifier)
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    private let saveTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Insira um nome para salvar sua consulta"
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.textColor = A.Colors.labelPrimary.color
        textField.setLeftPaddingPoints(13)
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.systemGray3.cgColor
        textField.layer.borderWidth = 1
        textField.backgroundColor = A.Colors.labelSecondary.color.withAlphaComponent(0.05)
        return textField
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
        addSubview(tableView)
        addSubview(popButton)
        addSubview(saveTextField)
        addSubview(saveButton)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            
            // tableView
            tableView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -10),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 320),
            
            // saveTextField
            saveTextField.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -10),
            saveTextField.leadingAnchor.constraint(equalTo: popButton.leadingAnchor),
            saveTextField.trailingAnchor.constraint(equalTo: popButton.trailingAnchor),
            saveTextField.heightAnchor.constraint(equalToConstant: 50),
            
            // saveButto
            saveButton.bottomAnchor.constraint(equalTo: popButton.topAnchor, constant: -22),
            saveButton.leadingAnchor.constraint(equalTo: popButton.leadingAnchor),
            saveButton.trailingAnchor.constraint(equalTo: popButton.trailingAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 45),
            
            // popButton
            popButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -18),
            popButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            popButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            popButton.heightAnchor.constraint(equalToConstant: 45),
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
    func setupView(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct ResultView_Preview: PreviewProvider {
  static var previews: some View {
      UIViewPreview {
          ResultView()
      }
  }
}
#endif
