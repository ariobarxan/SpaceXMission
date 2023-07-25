//
//  CoreDataService.swift
//  SpaceXMission
//
//  Created by Azhman Adam on 7/23/23.
//

import Foundation
import CoreData

protocol CoreDataServiceProtocol {
    var persistentContainer: NSPersistentContainer {get set}
    
    func saveContext ()
}

final class CoreDataService: CoreDataServiceProtocol {
    
    
    static let shared = CoreDataService()
    
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SpaceXMission")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // TODO: - Show Error
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
