//
//  BasketCoordinator.swift
//  Catberries
//
//  Created by Илья Черницкий on 31.07.23.
//

import UIKit

class CartCoordinator: SceneCoordinator {

    let viewModel: CartViewModel

    init(navigationController: UINavigationController, viewModel: CartViewModel) {
        self.viewModel = viewModel

        super.init(navigationController: navigationController)
    }

}
