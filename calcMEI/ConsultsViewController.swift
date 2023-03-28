//
//  ConsultsViewController.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 28/03/23.
//

import UIKit

class ConsultsViewController: UIViewController {
    
    // MARK: - Properties
    lazy var consultsView: ConsultsView = {
        let view = ConsultsView()
        view.delegate = self
        view.setupView(delegate: self, dataSource: self)
        return view
    }()
    
    var viewModel: ConsultsViewModel? {
        didSet {
            viewModel?.viewDelegate = self
            title = viewModel?.title
        }
    }
    
    // MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        view = consultsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        viewModel?.loadConsults()
    }
    
    // MARK: - Private Functions
}

// MARK: - ConsultsViewDelegate
extension ConsultsViewController: ConsultsViewDelegate {
    
    
    
}

// MARK: - SaveConsultViewModelViewDelegate
extension ConsultsViewController: ConsultsViewModelViewDelegate {
    
    func consultsViewModel(_ consultsViewModel: ConsultsViewModel, didUpdateConsults: [Consult]) {
        consultsView.reloadTableViewData()
    }
    
}

// MARK: - UITableViewDataSource
extension ConsultsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.consults.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ConsultTableViewCell.identifier, for: indexPath) as! ConsultTableViewCell
        let consult = viewModel?.consults[indexPath.row]
        cell.setupCell(with: consult)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
}
