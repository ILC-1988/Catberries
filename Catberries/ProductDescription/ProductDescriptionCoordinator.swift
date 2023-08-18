//
//  ProductDescriptionCoordinator.swift
//  Catberries
//
//  Created by Илья Черницкий on 17.08.23.
//

import UIKit

protocol ProductDescriptionProtocol: Coordinator {
    func showProductDescriptionViewController()
}

class ProductDescriptionCoordinator: ProductDescriptionProtocol {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .description }

    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    deinit {
        print("ProductDescriptionCoordinator deinit")
    }

    func start() {
        showProductDescriptionViewController()
    }

    func showProductDescriptionViewController() {
        let ProductDescriptionVC: ProductDescriptionViewController = .init()
        navigationController.pushViewController(ProductDescriptionVC, animated: true)
    }
}
