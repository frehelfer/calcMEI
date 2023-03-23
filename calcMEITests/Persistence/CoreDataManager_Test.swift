//
//  CoreDataManager_Test.swift
//  calcMEITests
//
//  Created by Frédéric Helfer on 23/03/23.
//

import CoreData

class CoreDataManager {
    
    private lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "calcMEI")
        let description = container.persistentStoreDescriptions.first
        description?.type = NSInMemoryStoreType
        
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        
        return container
    }()
    
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    func saveContext() {
        guard viewContext.hasChanges else { return }
        
        do {
            try viewContext.save()
        } catch {
            fatalError("Unresolved error \(error.localizedDescription)")
        }
    }
    
    func perform<T>(fetchRequest: NSFetchRequest<T>) -> [T]? where T : NSFetchRequestResult {
        do {
            let result = try viewContext.fetch(fetchRequest)
            return result
        } catch {
            return nil
        }
    }
    
}
