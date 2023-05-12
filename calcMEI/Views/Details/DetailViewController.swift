//
//  DetailViewController.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 28/03/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Properties
    lazy var detailView: DetailView = {
        let view = DetailView()
        view.setupView(delegate: self, dataSource: self)
        return view
    }()
    
    var viewModel: DetailViewModel? {
        didSet {
            viewModel?.viewDelegate = self
            title = viewModel?.title
        }
    }
    
    // MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        viewModel?.updateViewWithData()
    }
    
    // MARK: - Private Functions
    private func setupNavigationItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "trash"),
            style: .plain,
            target: self,
            action: #selector(deletePressed))
    }
    
    @objc private func deletePressed() {
        viewModel?.deleteSelected()
    }
    
}

// MARK: - DetailViewDelegate
extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel?.resultItems.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.resultItems[section].items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ResultTableViewCell.identifier, for: indexPath) as? ResultTableViewCell
        let data = viewModel?.resultItems[indexPath.section].items[indexPath.row]
        cell?.setupCell(data: data)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        48
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel?.resultItems[section].title
    }
    
}

// MARK: - DetailViewModelViewDelegate
extension DetailViewController: DetailViewModelViewDelegate {
    
    func detailViewModel(_ detailViewModel: DetailViewModel, updateViewWithItem: [DetailViewModel.ItemsGroup]) {
        detailView.reloadTableView()
    }
    
}
