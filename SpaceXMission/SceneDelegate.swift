//
//  SceneDelegate.swift
//  SpaceXMission
//
//  Created by Azhman Adam on 7/20/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var coordinator: MainCoordinator?
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        setupMainCoordinator(for: windowScene)
    }
}

// MARK: - Coordinator
@available(iOS 13.0, *)
extension SceneDelegate {
    
    private func setupMainCoordinator(for scene: UIWindowScene) {
        let window = UIWindow(windowScene: scene)
        let navController = UINavigationController()
        coordinator = MainCoordinator(navigationController: navController)
        coordinator?.start()
        window.rootViewController = navController
        self.window = window
        window.makeKeyAndVisible()
    }
}
