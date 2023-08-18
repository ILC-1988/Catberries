//
//  Coordinator.swift
//  Catberries
//
//  Created by Илья Черницкий on 31.07.23.
//

import UIKit

class SceneCoordinator {

    let navigationController: UINavigationController
    var tabBarController: UITabBarController?
    var childCoordinators = [Coordinator]()
    var type: CoordinatorType { .scene }

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: true)
    }

    func tabBarItemTapped(sender: Int) {
        print(sender)
     }

    func start() {
        showLoginFlow()
    }

    func showLoginFlow() {
        let loginCoordinator = LoginCoordinator.init(navigationController)
        loginCoordinator.start()
        loginCoordinator.finishDelegate = self
        childCoordinators.append(loginCoordinator)
    }

    func showMainFlow() {
        let tabCoordinator = TabCoordinator.init(navigationController)
        tabCoordinator.start()
        tabCoordinator.finishDelegate = self
        childCoordinators.append(tabCoordinator)
    }
}

extension SceneCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter({ $0.type != childCoordinator.type })

        switch childCoordinator.type {
        case .tab:
            navigationController.viewControllers.removeAll()
            showLoginFlow()
        case .login:
            navigationController.viewControllers.removeAll()
            showMainFlow()
        default:
            break
        }
    }
}
