//
//  SettingsScreen_SnapShotTests.swift
//  calcMEI_SnapShotTests
//
//  Created by Frédéric Helfer on 24/07/23.
//

import XCTest
import SnapshotTesting
@testable import calcMEI

final class SettingsScreen_SnapShotTests: XCTestCase {

    func test_SettingsViewController_withoutData() {
        let vc = SettingsViewController()
        let nav = UINavigationController(rootViewController: vc)
        assertSnapshot(matching: nav, as: .image(precision: 0.99))
    }
    
    func test_SettingsViewController_withData() {
        let vc = SettingsViewController()
        let viewModel = SettingsViewModelMock()
        viewModel.viewDelegate = vc
        vc.viewModel = viewModel
        
        let nav = UINavigationController(rootViewController: vc)
        assertSnapshot(matching: nav, as: .image(precision: 0.99))
    }
    
}

private extension SettingsScreen_SnapShotTests {
    
    class SettingsViewModelMock: SettingsViewModelProtocol {
        weak var viewDelegate: SettingsViewModelViewDelegate?
        
        init() {
            
        }
        
        var settingsData: [SettingsViewModel.SettingsSection] = []
        
        var title: String = "Configurações"
        
        func updateViewWithData() {
            let data = [
                SettingsViewModel.SettingsSection(title: "Links", details: [
                    SettingsViewModel.SettingsDetail(title: "Website", icon: "house.fill", color: A.Colors.blue.color, link: "https://calcmei.com.br"),
                    SettingsViewModel.SettingsDetail(title: "Linkedin", icon: "link", color: A.Colors.blue.color, link: "https://www.linkedin.com/in/fre-helfer")
                ]),
                SettingsViewModel.SettingsSection(title: "Documentos", details: [
                    SettingsViewModel.SettingsDetail(title: "Política de Privacidade", icon: "doc.text", color: A.Colors.labelPrimary.color.withAlphaComponent(0.6), link: "https://calcmei.com.br/privacidade.html"),
                    SettingsViewModel.SettingsDetail(title: "Termos de Uso", icon: "doc.text", color: A.Colors.labelPrimary.color.withAlphaComponent(0.6), link: "https://calcmei.com.br/termos-de-uso.html"),
                    SettingsViewModel.SettingsDetail(title: "Contato", icon: "pencil.circle.fill", color: A.Colors.labelPrimary.color.withAlphaComponent(0.6), link: "https://calcmei.com.br/contato.html")
                ])
            ]
                
            settingsData = data
            viewDelegate?.settingsViewModel(self, updateViewWith: settingsData)
        }
        
        var appVersion: String = "v 1.0 20"
        
        func didSelectRow(indexPath: IndexPath) {
            // don't need
        }
        
    }
}
