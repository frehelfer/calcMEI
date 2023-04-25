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
        view.delegate = self
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
extension DetailViewController: DetailViewDelegate {
    
    
    
}

// MARK: - DetailViewModelViewDelegate
extension DetailViewController: DetailViewModelViewDelegate {
    
    
    
}
