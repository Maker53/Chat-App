//
//  CoreDataStackImplementation.swift
//  Chat-App
//
//  Created by Станислав on 03.07.2022.
//

import CoreData

class CoreDataStackImplementation: CoreDataStack {
    
    // MARK: - Singleton
    
    static var shared: CoreDataStack = CoreDataStackImplementation()
    
    // MARK: - Public Properties
    
    lazy var readContext = persistentContainer.viewContext
    lazy var writeContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        context.parent = readContext
        
        return context
    }()
    
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: Constants.persistentContainerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        
        return container
    }()
    
    // MARK: - Private Initializer
    
    private init() {}
    
    // MARK: - Public Methods
    
    func fetchData<T>(inContext context: NSManagedObjectContext, withPredicate predicate: NSPredicate?) -> [T] where T: NSManagedObject {
        let fetchRequest = T.fetchRequest()
        
        if let predicate = predicate {
            fetchRequest.predicate = predicate
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
    
    func deleteData<T>(_ data: T) where T: NSManagedObject {
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
    
    // MARK: - Private Methods
    
    private func performSave(in context: NSManagedObjectContext) throws {
        try context.save()
        
        if let parent = context.parent {
            try performSave(in: parent)
        }
    }
}
