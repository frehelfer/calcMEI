//
//  HomeCoordinator.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 15/02/23.
//

import UIKit

protocol HomeCoordinatorDelegate: AnyObject {
    // add any func to rootCoordinator
}

class HomeCoordinator: Coordinator {
    
    weak var delegate: HomeCoordinatorDelegate?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    private let calcMEI_SDK: CalcMEI_SDK
    
    required init(navigationController: UINavigationController, calcMEI_SDK: CalcMEI_SDK) {
        self.navigationController = navigationController
        self.calcMEI_SDK = calcMEI_SDK
    }
    
    func start() {
        showHome()
    }
}

// MARK: - Navigation
private extension HomeCoordinator {
    
    func showHome() {
        navigationController.viewControllers = [
            homeViewController()
        ]
    }
    
    func showIncome() {
        navigationController.pushViewController(
            incomeViewController(),
            animated: true)
    }
    
    func showExpenses(count: Count) {
        navigationController.pushViewController(
            expensesViewController(count: count),
            animated: true)
    }
    
    func showResult(count: Count) {
        navigationController.pushViewController(
            resultViewController(count: count),
            animated: true)
    }
    
    func showSettings() {
        navigationController.present(
            settingsViewController(),
            animated: true)
    }
    
    func showSaveConsult(count: Count) {
        navigationController.present(
            UINavigationController(rootViewController: saveConsultViewController(count: count)),
            animated: true
        )
    }
    
    func pop() {
        let vc = navigationController.viewControllers[0]
        navigationController.popToViewController(vc, animated: true)
    }
    
}

// MARK: - View Controllers
private extension HomeCoordinator {
    
    func homeViewController() -> UIViewController {
        let viewController = HomeViewController()
        
        viewController.viewModel = {
            let viewModel = HomeViewModel()
            viewModel.coordinatorDelegate = self
            return viewModel
        }()
        
        return viewController
    }
    
    func incomeViewController() -> UIViewController {
        let viewController = IncomeViewController()
        
        viewController.viewModel = {
            let viewModel = IncomeViewModel()
            viewModel.coordinatorDelegate = self
            return viewModel
        }()
        
        return viewController
    }
    
    func expensesViewController(count: Count) -> UIViewController {
        let viewController = ExpensesViewController()
        
        viewController.viewModel = {
            let viewModel = ExpensesViewModel(
                count: count
            )
            viewModel.coordinatorDelegate = self
            return viewModel
        }()
        
        return viewController
    }
    
    func resultViewController(count: Count) -> UIViewController {
        let viewController = ResultViewController()
        
        viewController.viewModel = {
            let viewModel = ResultViewModel(
                count: count
            )
            viewModel.coordinatorDelegate = self
            return viewModel
        }()
        
        return viewController
    }
    
    func settingsViewController() -> UIViewController {
        let viewController = SettingsViewController()
        
        viewController.viewModel = {
            let viewModel = SettingsViewModel()
            viewModel.coordinatorDelegate = self
            return viewModel
        }()
        
        return viewController
    }
    
    func saveConsultViewController(count: Count) -> UIViewController {
        let viewController = SaveConsultViewController()
        
        viewController.viewModel = {
            let viewModel = SaveConsultViewModel(
                consultService: calcMEI_SDK.consultService,
                count: count
            )
            viewModel.coordinatorDelegate = self
            return viewModel
        }()
        
        return viewController
    }
    
}

// MARK: - HomeViewModelCoordinatorDelegate
extension HomeCoordinator: HomeViewModelCoordinatorDelegate {
    
    func homeViewModelDidSelectStart(_ homeViewModel: HomeViewModel) {
        showIncome()
    }
    
    func homeViewModelDidSelectSettings(_ homeViewModel: HomeViewModel) {
        showSettings()
    }

}

// MARK: - IncomeViewModelCoordinatorDelegate
extension HomeCoordinator: IncomeViewModelCoordinatorDelegate {
    
    func incomeViewModelDidSelectNext(_ incomeViewModel: IncomeViewModel, count: Count) {
        showExpenses(count: count)
    }

}

// MARK: - ExpensesViewModelCoordinatorDelegate
extension HomeCoordinator: ExpensesViewModelCoordinatorDelegate {
    
    func expensesViewModelDidSelectNext(_ expensesViewModel: ExpensesViewModel, count: Count) {
        showResult(count: count)
    }

}

// MARK: - ResultViewModelCoordinatorDelegate
extension HomeCoordinator: ResultViewModelCoordinatorDelegate {
    
    func resultViewModelDidSelectReset(_ resultViewModel: ResultViewModel) {
        pop()
    }
    
    func resultViewModelDidSelectSaveConsult(_ resultViewModel: ResultViewModel, count: Count) {
        showSaveConsult(count: count)
    }

}

// MARK: - SettingsViewModelCoordinatorDelegate
extension HomeCoordinator: SettingsViewModelCoordinatorDelegate {
    
    
    
}

// MARK: -
extension HomeCoordinator: SaveConsultViewModelCoordinatorDelegate {
    
    func saveConsultViewModelDidSelectSave(_ saveConsultViewModel: SaveConsultViewModel) {
        navigationController.dismiss(animated: true)
        pop()
    }
    
}

