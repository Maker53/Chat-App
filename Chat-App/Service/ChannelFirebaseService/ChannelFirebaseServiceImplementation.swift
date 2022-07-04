//
//  ChannelFirebaseServiceImplementation.swift
//  Chat-App
//
//  Created by Станислав on 03.07.2022.
//

import FirebaseFirestore

class ChannelFirebaseServiceImplementation: ChannelFirebaseService {
    
    private let firebaseService: FirebaseService = {
        var service = CoreAssembly.firebaseService
        
        service.collectionReference = service.db.collection(Constants.channelsCollectionPath)
        
        return service
    }()
    
    private let coreDataService = ServiceAssembly.coreDataService
    
    func listeningChannels() {
        firebaseService.addSnapshotListener { [weak self] result in
            switch result {
            case .success(let documents):
                documents.forEach { documentChange in
                    let document = documentChange.document
                    let identifier = document.documentID
                    let data = document.data()
                    guard let channel = Channel(identifier: identifier, data: data) else { return }
                    
                    switch documentChange.type {
                    case .added, .modified:
                        self?.coreDataService.insertOrUpdateChannel(channel)
                    case .removed:
                        self?.coreDataService.deleteChannel(channel)
                    }
                }
            case.failure(let error):
                print("Fetch channels error: ", error.localizedDescription)
            }
        }
    }
    
    func createChannel(name: String) {
        firebaseService.addDocument(data: ["name": name, "lastActivity": Timestamp(date: Date())]) { error in
            if let error = error {
                print("Channel not created: ", error.localizedDescription)
            }
        }
    }
    
    func deleteChannel(_ channel: Channel) {
        firebaseService.deleteDocument(identifier: channel.identifier) { error in
            if let error = error {
                print("Channel nor removed: ", error.localizedDescription)
            }
        }
    }
}
