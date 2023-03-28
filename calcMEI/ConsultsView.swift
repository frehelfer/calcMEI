//
//  ConsultsView.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 28/03/23.
//

import UIKit

protocol ConsultsViewDelegate: AnyObject {
    
}

class ConsultsView: UIView {
    
    weak var delegate: ConsultsViewDelegate?
    
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
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ConsultTableViewCell.self, forCellReuseIdentifier: ConsultTableViewCell.identifier)
        return tableView
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
        addSubview(tableView)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            
            // tableView
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
        ])
    }
    
    // MARK: - Private Actions
    
    // MARK: - Public Actions
    public func setupView(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }
    
    public func reloadTableViewData() {
        tableView.reloadData()
    }
}
