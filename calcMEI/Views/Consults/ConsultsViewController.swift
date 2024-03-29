//
//  ConsultsViewController.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 28/03/23.
//

import UIKit
import CalcMEI_Core
import CoreData

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
    
    func consultsViewModelWillChangeConsults() {
        consultsView.tableViewBeginUpdates()
    }
    
    func consultsViewModelUpdateConsults(_ controller: NSFetchedResultsController<NSFetchRequestResult>, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            consultsView.tableViewInsertRow(at: newIndexPath!)
        case .delete:
            consultsView.tableViewDeleteRow(at: indexPath!)
        case .move:
            break
        case .update:
            consultsView.tableViewUpdateRow(at: indexPath!)
        default:
            break
        }
        
        if let controller = controller.fetchedObjects, !controller.isEmpty {
            consultsView.hideEmptyView(animate: true)
        } else {
            consultsView.showEmptyView(animate: true)
        }
    }
    
    func consultsViewModelDidChangeConsults() {
        consultsView.tableViewEndUpdates()
    }
    
    func consultsViewModelShowDeleteAlert(title: String, message: String, confirmDeletePressed: @escaping (() -> Void)) {
        presentDeleteAlert(title: title, message: message) {
            confirmDeletePressed()
        }
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
        viewModel?.userEditingRow(indexPath: indexPath, editingStyle: editingStyle)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.detailSelected(indexPath: indexPath)
    }
    
}
