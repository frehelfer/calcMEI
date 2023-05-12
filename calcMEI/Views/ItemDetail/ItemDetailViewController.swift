//
//  SaveConsultViewController.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 23/03/23.
//

import UIKit

class ItemDetailViewController: UIViewController {
    
    // MARK: - Properties
    lazy var itemDetailView: ItemDetailView = {
        let itemDetailView = ItemDetailView()
        return itemDetailView
    }()
    
    var viewModel: ItemDetailViewModel? {
        didSet {
            viewModel?.viewDelegate = self
            title = viewModel?.title
        }
    }
    
    // MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        view = itemDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.updateViewWithData()
    }
    
}

// MARK: - ItemDetailViewModelViewDelegate
extension ItemDetailViewController: ItemDetailViewModelViewDelegate {
    
    func itemDetailViewModel(_ itemDetailViewModel: ItemDetailViewModel, updateViewWithData: ResultItem) {
        itemDetailView.updateView(with: updateViewWithData)
    }
    
}
