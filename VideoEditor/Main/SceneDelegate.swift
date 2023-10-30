//
//  SceneDelegate.swift
//  VideoEditor
//
//  Created by Ualikhan Sabden on 28.10.2023.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let windows = UIWindow(windowScene: windowScene)
        let welcomePageVC = WelcomePageVC()
        let navController = UINavigationController(rootViewController: welcomePageVC)
        windows.rootViewController = navController
        windows.makeKeyAndVisible()
        self.window = windows
    }
}

