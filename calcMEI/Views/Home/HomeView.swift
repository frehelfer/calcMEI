//
//  HomeView.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 15/02/23.
//

import UIKit

protocol HomeViewDelegate: AnyObject {
    func nextButtonPressed()
    func consultsButtonPressed()
    func lawLabelLinkPressed(_ gestureRecognizer: UITapGestureRecognizer)
}

class HomeView: UIView {
    
    weak var delegate: HomeViewDelegate?
    
    // MARK: - Properties
    private lazy var mainStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .center
        view.spacing = 6
        view.distribution = .fill
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = A.Colors.labelPrimary.color
        label.textAlignment = .center
        label.attributedText = makeTitleLabelText()
        label.numberOfLines = 0
        return label
    }()
    
    private func makeTitleLabelText() -> NSAttributedString {
        let firstTextAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 31, weight: .semibold)
        ]
        
        var secondTextAttributes = [NSAttributedString.Key : Any]()
        secondTextAttributes[.font] = UIFont.systemFont(ofSize: 35, weight: .semibold)
        
        let text = NSMutableAttributedString(string: S.Home.TitleLabel.FirstLine.text, attributes: firstTextAttributes)
        text.append(NSAttributedString(string: S.Home.TitleLabel.SecondLine.text, attributes: secondTextAttributes))
        
        return text
    }
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = A.Colors.labelSecondary.color
        label.text = S.Home.InfoLabel.text
        return label
    }()
    
    private lazy var lawLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.textColor = A.Colors.labelSecondary.color
        label.attributedText = makeLawLabelText()
        label.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(lawLabelLinkPressed))
        label.addGestureRecognizer(tapGesture)
        return label
    }()
    
    private func makeLawLabelText() -> NSAttributedString {
        let secondTextAttributes: [NSAttributedString.Key : Any] = [
            .foregroundColor : A.Colors.blue.color,
            .link : URL(string: S.Home.LawLabel.url)!
        ]
        
        let text = NSMutableAttributedString(string: S.Home.LawLabel.First.text)
        text.append(NSAttributedString(string: S.Home.LawLabel.Second.text, attributes: secondTextAttributes))
        
        return text
    }
    
    private lazy var savedConsultsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(S.Home.SavedConsultsButton.title, for: .normal)
        button.backgroundColor = A.Colors.buttonBlue.color
        button.setBackgroundColor(A.Colors.background.color.withAlphaComponent(0.5), for: .highlighted)
        
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(savedConsultsButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var newConsultButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(S.Home.NewConsultButton.title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button.backgroundColor = A.Colors.buttonBlue.color
        button.setBackgroundColor(A.Colors.background.color.withAlphaComponent(0.5), for: .highlighted)
        
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(newConsultButtonPressed), for: .touchUpInside)
        button.accessibilityIdentifier = "newConsultButton"
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
        addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.setCustomSpacing(40, after: titleLabel)
        mainStackView.addArrangedSubview(infoLabel)
        mainStackView.addArrangedSubview(lawLabel)
        
        addSubview(savedConsultsButton)
        addSubview(newConsultButton)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            
            // mainStackView
            mainStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 70),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            // savedConsultsButton
            savedConsultsButton.bottomAnchor.constraint(equalTo: newConsultButton.topAnchor, constant: -20),
            savedConsultsButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            savedConsultsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            savedConsultsButton.heightAnchor.constraint(equalToConstant: 45),
            
            // newConsultButton
            newConsultButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            newConsultButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            newConsultButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            newConsultButton.heightAnchor.constraint(equalToConstant: 65),
        ])
    }
    
    // MARK: - Private Actions
    @objc
    private func newConsultButtonPressed() {
        delegate?.nextButtonPressed()
    }
    
    @objc
    private func savedConsultsButtonPressed() {
        delegate?.consultsButtonPressed()
    }
    
    @objc
    private func lawLabelLinkPressed(_ gestureRecognizer: UITapGestureRecognizer) {
        delegate?.lawLabelLinkPressed(gestureRecognizer)
    }
    
    // MARK: - Public Actions
}
