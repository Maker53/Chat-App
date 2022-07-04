//
//  FetchControllerServiceImplementation.swift
//  Chat-App
//
//  Created by Станислав on 03.07.2022.
//

import CoreData

class FetchControllerServiceImplementation: FetchControllerService {
    
    private let coreDataStack = CoreAssembly.coreDataStack
    
    func createFetchController<T: NSManagedObject>(
        withSortDescriptor sortDescriptor: [NSSortDescriptor],
        andPredicate predicate: NSPredicate?
    ) -> NSFetchedResultsController<T>? {
        let context = coreDataStack.readContext
        let fetchRequest = T.fetchRequest()
        
        fetchRequest.sortDescriptors = sortDescriptor
        fetchRequest.predicate = predicate
        
        let controller = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil) as? NSFetchedResultsController<T>
        
        return controller
    }
    
}
