//
//  ViewController.swift
//  Catberries
//
//  Created by Илья Черницкий on 31.07.23.
//

import UIKit

class TabBarController: UITabBarController  {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstViewController = ProductViewController()
        let secondViewController = ProductInfoViewController()
        let thirdViewController = BasketViewController()
        
        let firstCoordinator = ProductCoordinator(navigationController: UINavigationController(), viewModel: firstViewController.viewModel)
        let secondCoordinator = ProductInfoCoordinator(navigationController: UINavigationController(), viewModel: secondViewController.viewModel)
        let thirdCoordinator = BasketCoordinator(navigationController: UINavigationController(), viewModel: thirdViewController.viewModel)
        
        let viewControllers = [firstViewController, secondViewController, thirdViewController]
        
        setViewControllers(viewControllers, animated: false)
        
        if let items = tabBar.items {
            for (index, item) in items.enumerated() {
                switch index {
                case 0:
                    item.title = "Товары"
                    item.image = UIImage(named: "firstIcon")
                    item.bind(to: firstCoordinator, at: 0)
                case 1:
                    item.title = "Инфо"
                    item.image = UIImage(named: "secondIcon")
                    item.bind(to: secondCoordinator, at: 1)
                case 2:
                    item.title = "Карзина"
                    item.image = UIImage(named: "thirdIcon")
                    item.bind(to: thirdCoordinator, at: 2)
                default:
                    break
                }
            }
        }
    }
}


