//
//  SceneDelegate.swift
//  Catberries
//
//  Created by Илья Черницкий on 20.07.23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: ProductCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        coordinator = ProductCoordinator()
        coordinator?.setRootViewController(ProductViewController())
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = coordinator?.rootViewController
        window?.makeKeyAndVisible()
        
    }
    
    
}

