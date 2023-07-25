//
//  AppDelegate.swift
//  SpaceXMission
//
//  Created by Azhman Adam on 7/20/23.
//

import UIKit
import CoreData

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var coordinator: Coordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupMainCoordinator()

        return true
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}


// MARK: - Coordinator
extension AppDelegate {
    
    private func setupMainCoordinator() {
        if #unavailable(iOS 13) {
            let navigationController = UINavigationController()
            navigationController.isNavigationBarHidden = true
            coordinator = MainCoordinator(navigationController: navigationController)
            coordinator?.start()
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
        }
    }
}
