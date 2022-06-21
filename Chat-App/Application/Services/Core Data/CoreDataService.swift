//
//  CoreDataService.swift
//  Chat-App
//
//  Created by Станислав on 20.06.2022.
//

import CoreData

class CoreDataService {
    private let persistentContainer: NSPersistentContainer = {
       let container = NSPersistentContainer(name: "Conversations")
        container.loadPersistentStores { _, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        
        return container
    }()
    
    private lazy var writeContext: NSManagedObjectContext = {
        let context = persistentContainer.newBackgroundContext()
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        return context
    }()
    
    private lazy var readContext = persistentContainer.viewContext
    
    func fetchData<T: NSManagedObject>() -> [T] {
        let fetchRequest = T.fetchRequest()
        guard let data = try? readContext.fetch(fetchRequest) as? [T] else { return [] }
        
        return data
    }
    
    func peformSave(_ block: @escaping (NSManagedObjectContext) -> Void) {
        let context = writeContext
        
        context.perform { [weak self] in
            block(context)
            
            if context.hasChanges {
                do {
                    try self?.performSave(in: context)
                } catch {
                    context.rollback()
                    print(error.localizedDescription)
                }
            }
        }
    }
    
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
