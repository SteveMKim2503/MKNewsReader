//
//  CoreDataStack.swift
//  MKNewsReader
//
//  Created by MK on 6/19/24.
//

import Foundation
import CoreData

final class CoreDataStack {
    
    // MARK: - Public Property
    
    static let shared = CoreDataStack()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MKNewsReader")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                dump(error, name: "error")
                let error = error as NSError
                fatalError("Failed to load persistent store: \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                dump(error, name: "error")
                let nserror = error as NSError
                fatalError("Failed to save context: \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Init
    
    private init() {}
}
