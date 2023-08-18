//
//  Coordinator.swift
//  Catberries
//
//  Created by Илья Черницкий on 17.08.23.
//

import UIKit

// MARK: - Coordinator
protocol Coordinator: class {
    var finishDelegate: CoordinatorFinishDelegate? { get set }

    var navigationController: UINavigationController { get set }

    var childCoordinators: [Coordinator] { get set }

    var type: CoordinatorType { get }

    func start()

    func finish()

    init(_ navigationController: UINavigationController)
}

extension Coordinator {
    func finish() {
        childCoordinators.removeAll()
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
}

protocol CoordinatorFinishDelegate: class {
    func coordinatorDidFinish(childCoordinator: Coordinator)
}

// MARK: - CoordinatorType

enum CoordinatorType {
    case scene, login, product, description, cart, setting
}
