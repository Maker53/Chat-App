//
//  CoreDataStack.swift
//  Chat-App
//
//  Created by Станислав on 03.07.2022.
//

import CoreData

protocol CoreDataStack {
    
    static var shared: CoreDataStack { get }
    
    var readContext: NSManagedObjectContext { get }
    var writeContext: NSManagedObjectContext { get }
    var persistentContainer: NSPersistentContainer { get }
    
    func fetchData<T: NSManagedObject>(inContext context: NSManagedObjectContext, withPredicate predicate: NSPredicate?) -> [T]
    func performSave(_ block: @escaping (NSManagedObjectContext) -> Void)
    func deleteData<T: NSManagedObject>(_ data: T)
}
