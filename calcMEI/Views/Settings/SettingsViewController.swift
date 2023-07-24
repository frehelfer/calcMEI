//
//  SettingsViewController.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 20/03/23.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: - Properties
    private lazy var settingsView: SettingsView = {
        let settingsView = SettingsView()
        settingsView.setupView(delegate: self, dataSource: self)
        settingsView.updateView(with: viewModel?.appVersion)
        return settingsView
    }()
    
    var viewModel: SettingsViewModelProtocol? {
        didSet {
            viewModel?.viewDelegate = self
            title = viewModel?.title
        }
    }
    
    // MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        view = settingsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setupNavigationAppearance(
            prefersLargeTitles: false,
            backgroundColor: A.Colors.navBar.color
        )
        setupNavigationItem()
        viewModel?.updateViewWithData()
    }
    
    // MARK: - Private Functions
    private func setupNavigationItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "xmark"),
            style: .done,
            target: self,
            action: #selector(dismissButtonPressed)
        )
    }
    
    @objc
    private func dismissButtonPressed() {
        dismiss(animated: true)
    }
}

// MARK: - UITableViewDelegate
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel?.settingsData.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.settingsData[section].details.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel?.settingsData[section].title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath) as? SettingsTableViewCell
        let data = viewModel?.settingsData[indexPath.section].details[indexPath.row]
        cell?.setupCell(with: data)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        56
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.didSelectRow(indexPath: indexPath)
    }
    
}

// MARK: - SettingsViewModelViewDelegate
extension SettingsViewController: SettingsViewModelViewDelegate {
    
    func settingsViewModel(_ settingsViewModel: SettingsViewModelProtocol, updateViewWith: [SettingsViewModel.SettingsSection]) {
        settingsView.reloadTableViewData()
    }
    
}

