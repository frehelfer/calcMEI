//
//  ContainerView.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 22/04/23.
//

import UIKit
import CurrencyUITextFieldDelegate
import CurrencyFormatter

class CustomFormContainer: UIView {
    
    // MARK: - Properties
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleView, textFieldView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical

        stackView.layer.cornerRadius = cornerRadius
        stackView.layer.borderWidth = 1

        stackView.layer.shadowColor = A.Colors.shadowMedium.color.cgColor
        stackView.layer.shadowRadius = 5
        stackView.layer.shadowOffset = CGSize(width: 5, height: 5)
        stackView.layer.shadowOpacity = 0.5
        return stackView
    }()
    
    // title
    private lazy var titleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.modifyCornerRadius(corner: .top, radius: cornerRadius)
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = A.Colors.labelPrimary.color
        return label
    }()
    
    // description
    private lazy var descriptionView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.textColor = A.Colors.labelPrimary.color.withAlphaComponent(0.8)
        return label
    }()
    
    // chevron
    private lazy var chevronButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.compact.down"), for: .normal)
        button.tintColor = A.Colors.labelPrimary.color.withAlphaComponent(0.6)
        button.addTarget(self, action: #selector(chevronTapped), for: .touchUpInside)
        return button
    }()
    
    // textfield
    private lazy var textFieldView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.modifyCornerRadius(corner: .bottom, radius: cornerRadius)
        return view
    }()
    
    private let categoryTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = S.TextField.MoneyPlaceHolder.text
        textField.font = UIFont.monospacedSystemFont(ofSize: 16, weight: .regular)
        textField.textColor = A.Colors.labelPrimary.color
        textField.keyboardType = .numberPad
        textField.returnKeyType = .next
        textField.textAlignment = .center
        return textField
    }()
    
    // MARK: - Init
    private var textFieldDelegate: CurrencyUITextFieldDelegate!
    
    var cornerRadius: CGFloat = 18
    
    init(title: String, description: String? = nil, colorType: ColorType) {
        super.init(frame: .zero)
        self.titleLabel.text = title
        configureDescription(text: description)
        configureColor(colorType: colorType)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureDescription(text: String?) {
        guard let text else { return }
        
        // description
        descriptionLabel.text = text
        stackView.insertArrangedSubview(descriptionView, at: 1)
        descriptionView.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            descriptionView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: descriptionView.topAnchor, constant: 10),
            descriptionLabel.bottomAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: -6),
            descriptionLabel.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor, constant: 18),
            descriptionLabel.trailingAnchor.constraint(equalTo: descriptionView.trailingAnchor, constant: -18),
        ])
        
        // chevron
        stackView.insertArrangedSubview(chevronButton, at: 2)
        NSLayoutConstraint.activate([
            chevronButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            chevronButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            chevronButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }

    func configureColor(colorType: ColorType) {
        switch colorType {
        case .green:
            stackView.layer.borderColor = A.Colors.green.color.withAlphaComponent(0.1).cgColor
            titleView.backgroundColor = A.Colors.green25.color
            descriptionView.backgroundColor = A.Colors.green25.color
            chevronButton.backgroundColor = A.Colors.green25.color
            textFieldView.backgroundColor = A.Colors.green50.color
        case .red:
            self.stackView.layer.borderColor = A.Colors.red.color.withAlphaComponent(0.1).cgColor
            titleView.backgroundColor = A.Colors.red25.color
            descriptionView.backgroundColor = A.Colors.red25.color
            chevronButton.backgroundColor = A.Colors.red25.color
            textFieldView.backgroundColor = A.Colors.red50.color
        }
    }
    
    // MARK: - SetupView
    private func setupView() {
        configureSubviews()
        configureConstraints()
        setupTextFieldWithCurrencyDelegate()
    }
    
    private func configureSubviews() {
        addSubview(stackView)
        
        titleView.addSubview(titleLabel)
        textFieldView.addSubview(categoryTextField)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),

            titleView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),

            textFieldView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            textFieldView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),

            titleLabel.topAnchor.constraint(equalTo: titleView.topAnchor, constant: 20),
            titleLabel.bottomAnchor.constraint(equalTo: titleView.bottomAnchor, constant: -6),
            titleLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: titleView.trailingAnchor, constant: -15),

            categoryTextField.topAnchor.constraint(equalTo: textFieldView.topAnchor, constant: 13),
            categoryTextField.bottomAnchor.constraint(equalTo: textFieldView.bottomAnchor, constant: -13),
            categoryTextField.leadingAnchor.constraint(equalTo: textFieldView.leadingAnchor),
            categoryTextField.trailingAnchor.constraint(equalTo: textFieldView.trailingAnchor, constant: -10),
            
        ])
    }
    
    private func setupTextFieldWithCurrencyDelegate() {
        let currencyFormatter = CurrencyFormatter {
            $0.maxValue = 100000000
            $0.currency = .brazilianReal
            $0.locale = CurrencyLocale.portugueseBrazil
            $0.hasDecimals = true
        }

        textFieldDelegate = CurrencyUITextFieldDelegate(formatter: currencyFormatter)
        textFieldDelegate.clearsWhenValueIsZero = true
        categoryTextField.delegate = textFieldDelegate
    }
    
    // MARK: - Private Actions
    @objc private func chevronTapped() {
        if descriptionView.isHidden == true {
            UIView.animate(withDuration: 0.4) {
                self.descriptionView.isHidden = false
                self.chevronButton.setImage(UIImage(systemName: "chevron.compact.up"), for: .normal)
            }
        } else {
            UIView.animate(withDuration: 0.4) {
                self.descriptionView.isHidden = true
                self.chevronButton.setImage(UIImage(systemName: "chevron.compact.down"), for: .normal)
            }
        }
    }
    
    // MARK: - Public Actions
    func getTextFieldValue() -> String? {
        guard let value = categoryTextField.text else { return nil }
        return value
    }
    
    enum ColorType {
        case green
        case red
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct ViewController_Preview: PreviewProvider {
  static var previews: some View {
      UIViewPreview {
          CustomFormContainer(title: "Título", description: "Essas despesas podem ser deduzidas do lucro da empresa, reduzindo assim a base de cálculo do imposto. Para isso, é necessário que as despesas estejam comprovadas por meio de nota fiscal e/ou recibo.", colorType: .red)
      }
      .padding(30)
  }
}
#endif
