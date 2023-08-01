//
//  ViewController.swift
//  Catberries
//
//  Created by Илья Черницкий on 31.07.23.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let firstViewController = ProductViewController()
        let secondViewController = CartViewController()
        let thirdViewController = SettingsViewController()

        let firstCoordinator = ProductCoordinator(
            navigationController: UINavigationController(),
            viewModel: firstViewController.viewModel)

        let secondCoordinator = CartCoordinator(
            navigationController: UINavigationController(),
            viewModel: secondViewController.viewModel)

        let thirdCoordinator = SettingsCoordinator(
            navigationController: UINavigationController(),
            viewModel: thirdViewController.viewModel)

        let viewControllers = [firstViewController, secondViewController, thirdViewController]

        setViewControllers(viewControllers, animated: true)

        if let items = tabBar.items {
            for (index, item) in items.enumerated() {
                switch index {
                case 0:
                    item.image = UIImage(systemName: "house")
                    item.bind(to: firstCoordinator, at: 0)
                case 1:
                    item.image = UIImage(systemName: "cart")
                    item.bind(to: secondCoordinator, at: 1)
                case 2:
                    item.image = UIImage(systemName: "gearshape")
                    item.bind(to: thirdCoordinator, at: 2)
                default:
                    break
                }
            }
        }
    }
}
