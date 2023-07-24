//
//  ConsultsViewController.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 28/03/23.
//

import UIKit
import CalcMEI_Core

class ConsultsViewController: UIViewController {
    
    // MARK: - Properties
    lazy var consultsView: ConsultsView = {
        let view = ConsultsView()
        view.delegate = self
        view.setupView(delegate: self, dataSource: self)
        return view
    }()
    
    var viewModel: ConsultsViewModelProtocol? {
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
        navigationController?.navigationBar.setupNavigationAppearance(
            prefersLargeTitles: true,
            backgroundColor: A.Colors.navBar.color,
            isTranslucent: false
        )
        setupNavigationItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        viewModel?.loadConsults()
    }
    
    // MARK: - Private Functions
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

// MARK: - ConsultsViewDelegate
extension ConsultsViewController: ConsultsViewDelegate {
    
    func newConsultButtonPressed() {
        viewModel?.newConsultSelected()
    }
    
}

// MARK: - ConsultsViewModelViewDelegate
extension ConsultsViewController: ConsultsViewModelViewDelegate {
    
    func consultsViewModel(_ consultsViewModel: ConsultsViewModelProtocol, didUpdateConsults: [Consult]) {
        consultsView.reloadTableViewData()
    }
    
    func consultsViewModelHasNoConsults(_ consultsViewModel: ConsultsViewModelProtocol) {
        consultsView.showEmptyView()
    }
    
}

// MARK: - UITableViewDataSource
extension ConsultsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getNumberOfRowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ConsultTableViewCell.identifier, for: indexPath) as! ConsultTableViewCell
        let data = viewModel?.getDataToCell(indexPath: indexPath)
        cell.setupCell(with: data)
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
            presentDeleteAlert(title: S.Detail.Alert.title, message: S.Detail.Alert.message) { [weak self] in
                guard let self else { return }
                viewModel?.remove(at: indexPath)
                consultsView.deleteTableViewRow(at: [indexPath])
                
                if let consults = viewModel?.consults, consults.isEmpty {
                    UIView.animate(withDuration: 0.7) { [weak self] in
                        self?.consultsView.showEmptyView()
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let consult = viewModel?.consults[indexPath.row] {        
            viewModel?.detailSelected(consult: consult)
        }
    }
    
}
