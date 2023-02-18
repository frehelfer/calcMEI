//
//  IncomeViewController.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 15/02/23.
//

import UIKit

class IncomeViewController: UIViewController {
    
    // MARK: - Properties
    private lazy var incomeView: IncomeView = {
        let homeView = IncomeView()
        homeView.delegate = self
        return homeView
    }()
    
    var viewModel: IncomeViewModel? {
        didSet {
            viewModel?.viewDelegate = self
            title = viewModel?.title
        }
    }
    
    // MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        view = incomeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStatusBar(color: .theme.navBar)
        setupVC()
    }
    
    // MARK: - Private Functions
    private func setupVC() {
        
        hideKeyboardWhenTappedAround()
        setupKeyboardHiding()
    }
    
    private func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

// MARK: - Keyboard
extension IncomeViewController {
    @objc func keyboardWillShow(sender: NSNotification) {
        guard let userInfo = sender.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentFirst() as? UITextField else { return }

        // check if the top of the keyboard is above the bottom of the currently focused textbox
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height

        // if textField bottom is below keyboard bottom - bump the frame up
        if textFieldBottomY > keyboardTopY {
            let textBoxY = convertedTextFieldFrame.origin.y
            let newFrameY = ((textBoxY - keyboardTopY / 2) * -1) + 150
            view.frame.origin.y = newFrameY
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
}

// MARK: - IncomeViewDelegate
extension IncomeViewController: IncomeViewDelegate {
    
    func nextButtonPressed() {
        viewModel?.nextSelected()
    }
}

// MARK: - IncomeViewModelViewDelegate
extension IncomeViewController: IncomeViewModelViewDelegate {
    
    
    
}
