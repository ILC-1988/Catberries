//
//  LoginCoordinator.swift
//  Catberries
//
//  Created by Илья Черницкий on 17.08.23.
//

import UIKit

protocol LoginCoordinatorProtocol: Coordinator {
    func showLoginViewController()
}

class LoginCoordinator: LoginCoordinatorProtocol {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .login }

    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    deinit {
        print("LoginCoordinator deinit")
    }

    func start() {
        showLoginViewController()
    }

    func showLoginViewController() {
        let loginVC: LoginViewController = .init()
        loginVC.didSendEventClosure = { [weak self] _ in
            self?.finish()
        }

        navigationController.pushViewController(loginVC, animated: true)
    }
}
