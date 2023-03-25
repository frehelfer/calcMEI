//
//  SaveConsultViewController.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 23/03/23.
//

import UIKit

class SaveConsultViewController: UIViewController {
    
    // MARK: - Properties
    lazy var saveConsultView: SaveConsultView = {
        let saveConsultView = SaveConsultView()
        saveConsultView.delegate = self
        return saveConsultView
    }()
    
    var viewModel: SaveConsultViewModel? {
        didSet {
            viewModel?.viewDelegate = self
            title = viewModel?.title
        }
    }
    
    // MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        view = saveConsultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        setStatusBar(color: .theme.navBar)
    }
    
    // MARK: - Private Functions
    private func setupVC() {
        hideKeyboardWhenTappedAround()
        setupNavigationItem()
    }
    
    private func setupNavigationItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "xmark"),
            style: .plain,
            target: self,
            action: #selector(dismissPressed))
    }
    
    @objc private func dismissPressed() {
        dismiss(animated: true)
    }
    
}

// MARK: - Actions
extension SaveConsultViewController {
    
}

// MARK: - SaveConsultViewDelegate
extension SaveConsultViewController: SaveConsultViewDelegate {
    
}

