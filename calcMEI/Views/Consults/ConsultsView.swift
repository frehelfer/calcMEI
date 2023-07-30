//
//  ConsultsView.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 28/03/23.
//

import UIKit

protocol ConsultsViewDelegate: AnyObject {
    func newConsultButtonPressed()
}

class ConsultsView: UIView {
    
    weak var delegate: ConsultsViewDelegate?
    
    // MARK: - Properties
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ConsultTableViewCell.self, forCellReuseIdentifier: ConsultTableViewCell.identifier)
        tableView.backgroundColor = A.Colors.background.color
        return tableView
    }()
    
    private lazy var emptyView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = A.Colors.background.color
        view.layer.opacity = 0
        return view
    }()
    
    private lazy var emptyTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = A.Colors.labelPrimary.color
        label.text = S.Consults.EmptyTitleLabel.text
        return label
    }()
    
    private lazy var newConsultButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(S.Consults.NewConsultButton.title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = A.Colors.buttonBlue.color
        button.setBackgroundColor(A.Colors.background.color.withAlphaComponent(0.5), for: .highlighted)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(newConsultButtonTapped), for: .touchUpInside)
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
        addSubview(emptyView)
        
        emptyView.addSubview(emptyTitleLabel)
        emptyView.addSubview(newConsultButton)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            
            // tableView
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            // emptyView
            emptyView.leadingAnchor.constraint(equalTo: leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: trailingAnchor),
            emptyView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            emptyView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            emptyTitleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor, constant: -120),
            emptyTitleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            
            newConsultButton.leadingAnchor.constraint(equalTo: emptyView.leadingAnchor, constant: 80),
            newConsultButton.trailingAnchor.constraint(equalTo: emptyView.trailingAnchor, constant: -80),
            newConsultButton.topAnchor.constraint(equalTo: emptyTitleLabel.bottomAnchor, constant: 30),
            newConsultButton.heightAnchor.constraint(equalToConstant: 45),
            
        ])
    }
    
    // MARK: - Private Actions
    @objc
    private func newConsultButtonTapped() {
        delegate?.newConsultButtonPressed()
    }
    
    // MARK: - Public Actions
    func setupView(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }
    
    func reloadTableViewData() {
        tableView.reloadData()
        self.emptyView.layer.opacity = 0
    }
    
    func showEmptyView(animate: Bool) {
        UIView.animate(withDuration: 0.7) { [weak self] in
            self?.emptyView.layer.opacity = 1
        }
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct ConsultsView_Preview: PreviewProvider {
  static var previews: some View {
      UIViewPreview {
          ConsultsView()
      }
  }
}
#endif
