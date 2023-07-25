//
//  MainCoordinator.swift
//  SpaceXMission
//
//  Created by Azhman Adam on 7/20/23.
//

import UIKit

// Delete Main Interface from info
final class MainCoordinator: NSObject, Coordinator {
    
    var childCoordinators  = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.delegate = self
        let vc = MissionListViewController.instantiate(.Main)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showMissionDetailViewController(forMission mission: Mission) {
        let vc = MissionDetailsViewController.instantiate(.Main)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
        vc.setup(forMission: mission)

    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}

// MARK: - UINavigationControllerDelegate
extension MainCoordinator: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        // TODO: - Azhman
        //handle popping the child coordinators from here
        
//        guard let sourceViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
//            return
//        }

        
//        if navigationController.viewControllers.contains(sourceViewController) {
//            return
//        }
//
//        if let vc = sourceViewController as? vc type {
//            childDidFinish(vc.coordinator)
//        }
    }
}

