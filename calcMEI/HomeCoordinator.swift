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
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
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
        navigationController.pushViewController(incomeViewController(), animated: true)
    }
    
    func showExpenses() {
        navigationController.pushViewController(expensesViewController(), animated: true)
    }
    
    func showResult() {
        navigationController.pushViewController(resultViewController(), animated: true)
    }
    
    func pop() {
        navigationController.viewControllers = [incomeViewController()]
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
    
    func expensesViewController() -> UIViewController {
        let viewController = ExpensesViewController()
        
        viewController.viewModel = {
            let viewModel = ExpensesViewModel()
            viewModel.coordinatorDelegate = self
            return viewModel
        }()
        
        return viewController
    }
    
    func resultViewController() -> UIViewController {
        let viewController = ResultViewController()
        
        viewController.viewModel = {
            let viewModel = ResultViewModel()
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

}

// MARK: - IncomeViewModelCoordinatorDelegate
extension HomeCoordinator: IncomeViewModelCoordinatorDelegate {
    
    func incomeViewModelDidSelectNext(_ incomeViewModel: IncomeViewModel) {
        showExpenses()
    }

}

// MARK: - ExpensesViewModelCoordinatorDelegate
extension HomeCoordinator: ExpensesViewModelCoordinatorDelegate {
    
    func expensesViewModelDidSelectNext(_ expensesViewModel: ExpensesViewModel) {
        showResult()
    }

}

// MARK: - ResultViewModelCoordinatorDelegate
extension HomeCoordinator: ResultViewModelCoordinatorDelegate {
    
    func resultViewModelDidSelectReset(_ resultViewModel: ResultViewModel) {
        pop()
    }

}

