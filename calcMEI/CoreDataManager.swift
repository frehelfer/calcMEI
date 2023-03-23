//
//  CoreDataManager.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 23/03/23.
//

import CoreData

public protocol CoreDataManaging {
    var viewContext: NSManagedObjectContext { get }
    func saveContext()
    func perform<T: NSFetchRequestResult>(fetchRequest: NSFetchRequest<T>) -> [T]?
}

class CoreDataManager: CoreDataManaging {
    
    private lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "calcMEI")
        
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
    
    func perform<T: NSFetchRequestResult>(fetchRequest: NSFetchRequest<T>) -> [T]? {
        do {
            let result = try viewContext.fetch(fetchRequest)
            return result
        } catch {
            return nil
        }
    }
    
}
