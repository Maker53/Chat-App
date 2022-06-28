//
//  CoreDataStack.swift
//  Chat-App
//
//  Created by Станислав on 20.06.2022.
//

import CoreData

class CoreDataStack {
    
    lazy var writeContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        context.parent = readContext
        
        return context
    }()
    
    lazy var readContext = persistentContainer.viewContext
    
    private let persistentContainer: NSPersistentContainer = {
       let container = NSPersistentContainer(name: "Conversations")
        container.loadPersistentStores { _, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        
        return container
    }()
    
    func fetchData<T: NSManagedObject>(withPredicate predicate: NSPredicate? = nil, inContext userContext: NSManagedObjectContext? = nil) -> [T] {
        let fetchRequest = T.fetchRequest()
        var context = readContext
        
        if let predicate = predicate {
            fetchRequest.predicate = predicate
        }
        
        if let userContext = userContext {
            context = userContext
        }
        
        guard let data = try? context.fetch(fetchRequest) as? [T] else { return [] }
        
        return data
    }
    
    func performSave(_ block: @escaping (NSManagedObjectContext) -> Void) {
        writeContext.performAndWait {
            block(writeContext)
            
            if writeContext.hasChanges {
                do {
                    try performSave(in: writeContext)
                } catch {
                    writeContext.rollback()
                    print(error.localizedDescription)
                }
            }
            
            writeContext.reset()
        }
    }
    
    func deleteData<T: NSManagedObject>(_ data: T) {
        performSave { context in
            context.delete(data)
        }
    }
    
    // TODO remove this func
    
    func deleteALl() {
        let storeContainer =
            persistentContainer.persistentStoreCoordinator

        // Delete each existing persistent store
        for store in storeContainer.persistentStores {
            guard let url = store.url else { return }
            try? storeContainer.destroyPersistentStore(
                at: url,
                ofType: store.type,
                options: nil
            )
        }
    }
    
    private func performSave(in context: NSManagedObjectContext) throws {
        try context.save()
        
        if let parent = context.parent {
            try performSave(in: parent)
        }
    }
}
