//
//  DataStoreManager.swift
//  BestCalculator
//
//  Created by talgar osmonov on 18/5/21.
//

import Foundation
import CoreData

class DataStoreManager {
    
    public static let shared = DataStoreManager()
    
    let fetchRequest: NSFetchRequest<Equation> = Equation.fetchRequest()
    
    lazy var fetchResultController: NSFetchedResultsController<Equation> = {
        let fetchRC = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        return fetchRC
    }()
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "BestCalculator")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}


