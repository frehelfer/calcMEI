//
//  HomeViewController.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 15/02/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    private lazy var homeView: HomeView = {
        let homeView = HomeView()
        homeView.delegate = self
        return homeView
    }()
    
    var viewModel: HomeViewModel? {
        didSet {
            viewModel?.viewDelegate = self
            title = viewModel?.title
        }
    }
    
    // MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setupNavigationItem()
    }
    
    // MARK: - Private Functions
    private func setupNavigationItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gear"),
            style: .done,
            target: self,
            action: #selector(settingsButtonPressed)
        )
    }
    
    // MARK: - Navigation
    @objc private func settingsButtonPressed() {
        viewModel?.settingsSelected()
    }
    
}

// MARK: - HomeViewDelegate
extension HomeViewController: HomeViewDelegate {
    
    func nextButtonPressed() {
        viewModel?.startSelected()
    }
    
    func consultsButtonPressed() {
        viewModel?.consultsSelected()
    }
    
    // TODO: Executar esse função na view, viewController ou viewModel?
    
    func lawLabelLinkPressed(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let label = gestureRecognizer.view as? UILabel else { return }
            
        // Get the range of the tapped word
        let point = gestureRecognizer.location(in: label)
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let attributedText = label.attributedText ?? NSAttributedString()
        let textStorage = NSTextStorage(attributedString: attributedText)
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        let characterIndex = layoutManager.characterIndex(for: point, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        let attributeName = NSAttributedString.Key.link
        let value = label.attributedText?.attribute(attributeName, at: characterIndex, effectiveRange: nil) as? NSURL
        
        if let url = value as URL? {
            // Handle the tap on the hyperlink
            print("Tapped URL: \(url)")
            UIApplication.shared.open(url)
        }
    }
    
}

// MARK: - HomeViewModelViewDelegate
extension HomeViewController: HomeViewModelViewDelegate {
    
    
    
}
