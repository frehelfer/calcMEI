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
        return saveConsultView
    }()
    
    var viewModel: SaveConsultViewModel? {
        didSet {
            viewModel?.viewDelegate = self
        }
    }
    
    // MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        view = saveConsultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

// MARK: - Actions
extension SaveConsultViewController {
    
}

// MARK: - SaveConsultViewDelegate
extension SaveConsultViewController: SaveConsultViewDelegate {
    
}

