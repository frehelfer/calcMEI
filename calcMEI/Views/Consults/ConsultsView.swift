//
//  ConsultsView.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 28/03/23.
//

import UIKit

class ConsultsView: UIView {
    
    // MARK: - Properties
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ConsultTableViewCell.self, forCellReuseIdentifier: ConsultTableViewCell.identifier)
        tableView.backgroundColor = A.Colors.background.color
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
        backgroundColor = A.Colors.background.color
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
    
    public func deleteTableViewRow(at rows: [IndexPath]) {
        tableView.deleteRows(at: rows, with: .fade)
    }
}
