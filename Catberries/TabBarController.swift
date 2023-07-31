//
//  TabBarController.swift
//  Catberries
//
//  Created by Илья Черницкий on 31.07.23.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    let coordinator: Coordinator
    var coordinatorDict: [Int: Coordinator] = [:]
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        
        // Создаем вью-контроллеры
        let firstViewController = ProductViewController()
        let secondViewController = ProductInfoViewController()
        let thirdViewController = BasketViewController()

        // Создаем координаторы для каждого вью-контроллера
        let firstCoordinator = ProductCoordinator(navigationController: UINavigationController(), viewModel: firstViewController.viewModel)
        let secondCoordinator = ProductInfoCoordinator(navigationController: UINavigationController(), viewModel: secondViewController.viewModel)
        let thirdCoordinator = BasketCoordinator(navigationController: UINavigationController(), viewModel: thirdViewController.viewModel)

        coordinatorDict[0] = firstCoordinator
        coordinatorDict[1] = secondCoordinator
        coordinatorDict[2] = thirdCoordinator
        
        let firstTabBarItem = UITabBarItem(title: "Первый", image: UIImage(named: "firstIcon"), tag: 0)
        firstTabBarItem.bind(to: coordinator, at: 0)
        firstViewController.tabBarItem = firstTabBarItem
        
        let secondTabBarItem = UITabBarItem(title: "Второй", image: UIImage(named: "secondIcon"), tag: 1)
        secondTabBarItem.bind(to: coordinator, at: 1)
        secondViewController.tabBarItem = secondTabBarItem
        
        let thirdTabBarItem = UITabBarItem(title: "Третий", image: UIImage(named: "thirdIcon"), tag: 2)
        thirdTabBarItem.bind(to: coordinator, at: 2)
        thirdViewController.tabBarItem = thirdTabBarItem
        
        let viewControllers = [firstViewController, secondViewController, thirdViewController]
        
        self.setViewControllers(viewControllers, animated: false)
    }
    
    // UITabBarControllerDelegate
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let viewControllers = tabBarController.viewControllers,
           let index = viewControllers.firstIndex(of: viewController) {
            coordinator.tabBarItemTapped(sender: index)
        }
    }
    
    // ...
}
