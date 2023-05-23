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
        resultView.setupView(delegate: self, dataSource: self, textfield: self)
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
        setupKeyboardHiding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.updateViewWithCount()
    }
    
    // MARK: - Private Functions
    private func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

extension ResultViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.resultItems.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ResultTableViewCell.identifier, for: indexPath) as? ResultTableViewCell
        let data = viewModel?.resultItems[indexPath.row]
        cell?.setupCell(data: data)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.didSelectRow(indexPath: indexPath)
    }
    
}

// MARK: - UITextFieldDelegate
extension ResultViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
}

// MARK: - ResultViewDelegate
extension ResultViewController: ResultViewDelegate {
    
    func nextButtonPressed() {
        viewModel?.resetSelected()
    }
    
    func saveButtonPressed(_ text: String) {
        viewModel?.saveConsultSelected(text)
    }
    
}

// MARK: - ResultViewModelViewDelegate
extension ResultViewController: ResultViewModelViewDelegate {
    
    func resultViewModel(_ resultViewMode: ResultViewModel, updateViewWithCount: [ResultItem]) {
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
