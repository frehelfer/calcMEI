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
        setupVC()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        viewModel?.loadConsults()
    }
    
    // MARK: - Private Functions
    private func setupVC() {
        setStatusBar(color: .theme.navBar)
        setupNavigationItem()
    }
    
    private func setupNavigationItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(newConsultPressed))
    }
    
    @objc private func newConsultPressed() {
        viewModel?.newConsultSelected()
    }
}

// MARK: - SaveConsultViewModelViewDelegate
extension ConsultsViewController: ConsultsViewModelViewDelegate {
    
    func consultsViewModel(_ consultsViewModel: ConsultsViewModel, didUpdateConsults: [Consult]) {
        consultsView.reloadTableViewData()
    }
    
}

// MARK: - UITableViewDataSource
extension ConsultsViewController: UITableViewDataSource {
    
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

// MARK: - UITableViewDelegate
extension ConsultsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel?.remove(at: indexPath.row)
            consultsView.deleteTableViewRow(at: [indexPath])
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }
    
}
