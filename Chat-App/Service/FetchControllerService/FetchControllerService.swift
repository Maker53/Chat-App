//
//  FetchControllerService.swift
//  Chat-App
//
//  Created by Станислав on 03.07.2022.
//

import CoreData

protocol FetchControllerService {
    
    func createFetchController<T: NSManagedObject>(
        withSortDescriptor sortDescriptor: [NSSortDescriptor],
        andPredicate predicate: NSPredicate?
    ) -> NSFetchedResultsController<T>?
}
