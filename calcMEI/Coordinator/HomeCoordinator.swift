//
//  HomeCoordinator.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 15/02/23.
//

import UIKit
import CalcMEI_Core

protocol HomeCoordinatorDelegate: AnyObject {
    // add any func to rootCoordinator
}

class HomeCoordinator: Coordinator {
    
    weak var delegate: HomeCoordinatorDelegate?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    private let calcMEI_core: CalcMEI_Core
    
    required init(navigationController: UINavigationController, calcMEI_core: CalcMEI_Core) {
        self.navigationController = navigationController
        self.calcMEI_core = calcMEI_core
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
            UINavigationController(rootViewController: settingsViewController()),
            animated: true)
    }
    
    func showItemDetail(itemDetail: ResultItem) {
        navigationController.pushViewController(
            itemDetailViewController(itemDetail: itemDetail),
            animated: true
        )
    }
    
    func showConsults() {
        navigationController.pushViewController(
            consultsViewController(),
            animated: true
        )
    }
    
    func showDetail(consult: Consult) {
        navigationController.pushViewController(
            detailViewController(consult: consult),
            animated: true
        )
    }
    
    func pop(index: Int = 0) {
        let vc = navigationController.viewControllers[index]
        navigationController.popToViewController(vc, animated: true)
    }
    
}

// MARK: - View Controllers
private extension HomeCoordinator {
    
    func homeViewController() -> UIViewController {
        let viewController = HomeViewController()
        
        viewController.viewModel = {
            let viewModel = HomeViewModel(
                analyticsService: calcMEI_core.analyticsService
            )
            viewModel.coordinatorDelegate = self
            return viewModel
        }()
        
        return viewController
    }
    
    func incomeViewController() -> UIViewController {
        let viewController = IncomeViewController()
        
        viewController.viewModel = {
            let viewModel = IncomeViewModel(
                analyticsService: self.calcMEI_core.analyticsService
            )
            viewModel.coordinatorDelegate = self
            return viewModel
        }()
        
        return viewController
    }
    
    func expensesViewController(count: Count) -> UIViewController {
        let viewController = ExpensesViewController()
        
        viewController.viewModel = {
            let viewModel = ExpensesViewModel(
                count: count,
                analyticsService: self.calcMEI_core.analyticsService
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
                count: count,
                consultService: calcMEI_core.consultService
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
    
    func itemDetailViewController(itemDetail: ResultItem) -> UIViewController {
        let viewController = ItemDetailViewController()
        
        viewController.viewModel = {
            let viewModel = ItemDetailViewModel(
                itemDetail: itemDetail
            )
            return viewModel
        }()
        
        return viewController
    }
    
    func consultsViewController() -> UIViewController {
        let viewController = ConsultsViewController()
        
        viewController.viewModel = {
            let viewModel = ConsultsViewModel(
                consultService: calcMEI_core.consultService
            )
            viewModel.coordinatorDelegate = self
            return viewModel
        }()
        
        return viewController
    }
    
    func detailViewController(consult: Consult) -> UIViewController {
        let viewController = DetailViewController()
        
        viewController.viewModel = {
            let viewModel = DetailViewModel(
                consultService: calcMEI_core.consultService,
                consult: consult
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
    
    func homeViewModelDidSelectConsults(_ homeViewModel: HomeViewModel) {
        showConsults()
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
    
    func resultViewModelDidSelectItemDetail(_ resultViewModel: ResultViewModel, resultItem: ResultItem) {
        showItemDetail(itemDetail: resultItem)
    }
    
    func resultViewModelDidSelectReset(_ resultViewModel: ResultViewModel) {
        pop()
    }

}

// MARK: - SettingsViewModelCoordinatorDelegate
extension HomeCoordinator: SettingsViewModelCoordinatorDelegate {
    
    
    
}

// MARK: - ConsultsViewModelCoordinatorDelegate
extension HomeCoordinator: ConsultsViewModelCoordinatorDelegate {
    
    func consultsViewModelDidSelectNewConsult(_ consultsViewModel: ConsultsViewModel) {
        showIncome()
    }
    
    func consultsViewModelDidSelectDetail(_ consultsViewModel: ConsultsViewModel, consult: Consult) {
        showDetail(consult: consult)
    }

}

// MARK: - DetailViewModelCoordinatorDelegate
extension HomeCoordinator: DetailViewModelCoordinatorDelegate {
    
    func detailViewModelDidSelectItemDetail(_ detailViewModel: DetailViewModel, resultItem: ResultItem) {
        showItemDetail(itemDetail: resultItem)
    }
    
    func detailViewModelDidSelectDismiss(_ detailViewModel: DetailViewModel) {
        pop(index: 1)
    }
    
}
