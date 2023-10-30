//
//  AppDelegate.swift
//  VideoEditor
//
//  Created by Ualikhan Sabden on 28.10.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let windows = UIWindow(frame: UIScreen.main.bounds)
        let welcomePageVC = WelcomePageVC()
        let navController = UINavigationController(rootViewController: welcomePageVC)
        windows.rootViewController = navController
        windows.makeKeyAndVisible()
        self.window = windows
        return true
    }

}
