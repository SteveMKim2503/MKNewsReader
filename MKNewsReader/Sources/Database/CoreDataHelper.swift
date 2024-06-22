//
//  CoreDataHelper.swift
//  MKNewsReader
//
//  Created by MK on 6/19/24.
//

import Foundation
import CoreData

final class CoreDataHelper {
    
    // MARK: - Public Property
    
    static let shared = CoreDataHelper()
    
    // MARK: - Private Property
    
    private let coreDataStack = CoreDataStack.shared
    private let context: NSManagedObjectContext
    
    // MARK: - Init
    
    private init() {
        context = coreDataStack.context
    }
    
    // MARK: - Public Function
    
    func createEntity<T: NSManagedObject>(ofType type: T.Type) -> T {
        let entityName = String(describing: type)
        guard let entity = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context) as? T else {
            fatalError("Unable to create entity of type \(type)")
        }
        return entity
    }
    
    func fetchEntities<T: NSManagedObject>(ofType type: T.Type, withPredicate predicate: NSPredicate? = nil) -> [T] {
        let entityName = String(describing: type)
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)
        fetchRequest.predicate = predicate
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            dump(error, name: "Failed to fetch entities of type \(type)")
            return []
        }
    }
    
    func updateEntity(_ entity: NSManagedObject) {
        guard let context = entity.managedObjectContext, context == coreDataStack.context else {
            print("Entity does not exist in the current context")
            return
        }
        
        saveContext()
    }
    
    func deleteEntity(_ entity: NSManagedObject) {
        context.delete(entity)
        saveContext()
    }
    
    func deleteAll<T: NSManagedObject>(ofType type: T.Type) {
        let entityName = String(describing: type)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(batchDeleteRequest)
            saveContext()
        } catch {
            dump(error, name: "Failed to delete all records for entity \(entityName)")
        }
    }
    
    func saveContext() {
        coreDataStack.saveContext()
    }
}
