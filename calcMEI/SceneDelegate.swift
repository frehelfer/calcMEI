//
//  SceneDelegate.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 15/02/23.
//

import UIKit
import CalcMEI_Core

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var rootCoordinator: Coordinator?
    
    var calcMEI_core: CalcMEI_Core = CalcMEI_Core()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        setupNavigationBarAppearance()
        
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        
        let navigationController = BaseNavigationController()
        window?.rootViewController = navigationController
        
        rootCoordinator = RootCoordinator(
            navigationController: navigationController,
            calcMEI_core: calcMEI_core
        )
        rootCoordinator?.start()
    }
    
    private func setupNavigationBarAppearance() {
        let standard = UINavigationBarAppearance()
        standard.configureWithOpaqueBackground()
        standard.backgroundColor = A.Colors.navBar.color
        
//        let buttonAppearance = standard.buttonAppearance.normal
//        buttonAppearance.titleTextAttributes = [:]
        
        UINavigationBar.appearance().standardAppearance = standard
        UINavigationBar.appearance().scrollEdgeAppearance = standard
//        UINavigationBar.appearance().compactAppearance = standard
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}

}

