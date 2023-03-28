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
}

// MARK: - Actions
extension ConsultsViewController {
 
    
    
}

// MARK: - ConsultsViewDelegate
extension ConsultsViewController: ConsultsViewDelegate {
    
    
    
}

// MARK: - SaveConsultViewModelViewDelegate
extension ConsultsViewController: ConsultsViewModelViewDelegate {
    
    func consultsViewModel(_ consultsViewModel: ConsultsViewModel, didUpdateConsults: [Consult]) {
        // TODO: send data to view or update tableView on SELF
    }
    
}
