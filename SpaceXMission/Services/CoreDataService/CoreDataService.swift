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
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
