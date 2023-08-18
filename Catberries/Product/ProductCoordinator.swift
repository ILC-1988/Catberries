//
//  ProductCoordinator.swift
//  Catberries
//
//  Created by Илья Черницкий on 31.07.23.
//

import UIKit

class ProductCoordinator: SceneCoordinator {
    let viewModel: ProductViewModel

    init(navigationController: UINavigationController, viewModel: ProductViewModel) {
        self.viewModel = viewModel
        super.init(navigationController: navigationController)

        self.viewModel.didSelectCell = { [self] indexPath in
            self.goToProductDescriptionPage()
        }
    }

    func goToProductDescriptionPage() {
        let vcDescription :ProductDescriptionViewController = .init()
        navigationController.pushViewController(vcDescription, animated: true)
    }
}
