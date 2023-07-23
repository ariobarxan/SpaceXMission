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
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        CoreDataService.shared.saveContext()
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
