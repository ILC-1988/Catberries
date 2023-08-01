//
//  ProductInfoCoordinator.swift
//  Catberries
//
//  Created by Илья Черницкий on 31.07.23.
//

import UIKit

class SettingsCoordinator: Coordinator {

    let viewModel: SettingsViewModel

    init(navigationController: UINavigationController, viewModel: SettingsViewModel) {
        self.viewModel = viewModel

        super.init(navigationController: navigationController)
    }

}
