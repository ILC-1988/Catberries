//
//  SceneDelegate.swift
//  Catberries
//
//  Created by Илья Черницкий on 20.07.23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: SceneCoordinator?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        let navigationController = UINavigationController.init()

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        
        coordinator = SceneCoordinator(navigationController: navigationController)
        coordinator?.start()
    }
}
