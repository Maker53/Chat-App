//
//  CoreAssembly.swift
//  Chat-App
//
//  Created by Станислав on 03.07.2022.
//

class CoreAssembly {
    
    static let firebaseService: FirebaseService = FirebaseServiceImplementation()
    static var coreDataStack: CoreDataStack = CoreDataStackImplementation.shared
    static var storageService: StorageService = StorageServiceImplementation()
    static var requestService: RequestSender = RequestSenderImplementation()
}
