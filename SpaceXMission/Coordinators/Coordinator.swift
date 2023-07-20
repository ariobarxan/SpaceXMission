//
//  Coordinator.swift
//  SpaceXMission
//
//  Created by Azhman Adam on 7/20/23.
//

import UIKit

protocol Coordinator: NSObject {
    var childCoordinators: [Coordinator] {get set}
    var navigationController: UINavigationController {get set}
        
    func start()
}
