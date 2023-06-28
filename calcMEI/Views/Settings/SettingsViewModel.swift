//
//  SettingsViewModel.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 20/03/23.
//

import UIKit
import CalcMEI_Core

protocol SettingsViewModelViewDelegate: AnyObject {
    func settingsViewModel(_ settingsViewModel: SettingsViewModel, updateViewWith: [SettingsViewModel.SettingsSection])
}

class SettingsViewModel {
    
    weak var viewDelegate: SettingsViewModelViewDelegate?
    
    private let analyticsService: AnalyticsServiceProtocol
    
    init(analyticsService: AnalyticsServiceProtocol) {
        self.analyticsService = analyticsService
    }
    
    var settingsData: [SettingsSection] = []
    
    var title: String = S.Settings.title
    
    func updateViewWithData() {
        let data = [
            SettingsSection(title: "Links", details: [
                SettingsDetail(title: "Website", icon: "house.fill", color: A.Colors.blue.color, link: "https://calcmei.com.br"),
                SettingsDetail(title: "Linkedin", icon: "link", color: A.Colors.blue.color, link: "https://www.linkedin.com/in/fre-helfer")
            ]),
            SettingsSection(title: "Documentos", details: [
                SettingsDetail(title: "Política de Privacidade", icon: "doc.text", color: A.Colors.labelPrimary.color.withAlphaComponent(0.6), link: "https://calcmei.com.br/privacidade.html"),
                SettingsDetail(title: "Termos de Uso", icon: "doc.text", color: A.Colors.labelPrimary.color.withAlphaComponent(0.6), link: "https://calcmei.com.br/termos-de-uso.html"),
                SettingsDetail(title: "Contato", icon: "pencil.circle.fill", color: A.Colors.labelPrimary.color.withAlphaComponent(0.6), link: "https://calcmei.com.br/contato.html")
            ])
        ]
            
        settingsData = data
        viewDelegate?.settingsViewModel(self, updateViewWith: settingsData)
    }
    
    var appVersion: String {
        guard
            let versionNumber = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
            let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
        else {
            return ""
        }
        
        return "v\(versionNumber) \(buildNumber)"
    }
    
    func didSelectRow(indexPath: IndexPath) {
        let item = settingsData[indexPath.section].details[indexPath.row]
        let link = item.link
        
        analyticsService.logEvent(name: "SettingsView_DidSelectRow", params: ["Row" : "\(item.title)"])
        
        guard let url = URL(string: link) else { return }
        
        UIApplication.shared.open(url)
    }
}

// MARK: - Navigation
extension SettingsViewModel {
    
    struct SettingsSection {
        let title: String
        let details: [SettingsDetail]
    }
    
    struct SettingsDetail {
        let title: String
        let icon: String
        let color: UIColor
        let link: String
    }
    
}
