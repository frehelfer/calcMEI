//
//  ResultViewController.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 15/02/23.
//

import UIKit
import CalcMEI_Core

class ResultViewController: UIViewController {
    
    // MARK: - Properties
    private lazy var resultView: ResultView = {
        let resultView = ResultView()
        resultView.delegate = self
        resultView.setupView(delegate: self, dataSource: self)
        return resultView
    }()
    
    var viewModel: ResultViewModel? {
        didSet {
            viewModel?.viewDelegate = self
            title = viewModel?.title
        }
    }
    
    // MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        view = resultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        viewModel?.updateViewWithCount()
    }
    
    // MARK: - Private Functions
}

extension ResultViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ResultTableViewCell.identifier, for: indexPath) as? ResultTableViewCell
        let data = viewModel?.data[indexPath.row]
        cell?.setupCell(data: data)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        55
    }
    
}

// MARK: - ResultViewDelegate
extension ResultViewController: ResultViewDelegate {
    
    func nextButtonPressed() {
        viewModel?.resetSelected()
    }
    
    func saveButtonPressed() {
        viewModel?.saveConsultSelected()
    }
    
}

// MARK: - ResultViewModelViewDelegate
extension ResultViewController: ResultViewModelViewDelegate {
    
    func resultViewModel(_ resultViewMode: ResultViewModel, updateViewWithCount: [ResultViewModel.NestedResult]) {
        resultView.reloadTableView()
    }
    
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct ResultViewController_Preview: PreviewProvider {
  static var previews: some View {
      UIViewControllerPreview {
          ResultViewController()
      }
  }
}
#endif
