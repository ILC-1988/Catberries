//
//  SceneDelegate.swift
//  Catberries
//
//  Created by Илья Черницкий on 20.07.23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var tabBarController: TabBarController?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)
        tabBarController = TabBarController()
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}

    


