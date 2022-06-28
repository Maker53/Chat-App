//
//  FirebaseService.swift
//  Chat-App
//
//  Created by Станислав on 30.05.2022.
//

import FirebaseFirestore

class FirebaseService {
    
    // MARK: - Singletone
    
    static let shared = FirebaseService()
    
    // MARK: - Private Properties
    
    private lazy var channelsReference = Firestore.firestore().collection(Constants.channelsCollectionPath)
    private var userName: String {
        StorageManager.fetchObjectFromFile().name ?? ""
    }
    
    // MARK: - Private initialiser
    
    private init() {}
    
    // MARK: - Public Methods
    
    func getChannels() {
        channelsReference.addSnapshotListener { snapshot, error in
            if let error = error {
                // TODO add alert?
                print(error.localizedDescription)
                return
            }
            
            snapshot?.documentChanges.forEach { documentChange in
                let document = documentChange.document
                let identifier = document.documentID
                let data = document.data()
                guard let channel = Channel(identifier: identifier, data: data) else { return }
                
                switch documentChange.type {
                case .added, .modified:
                    CoreDataService.shared.insertOrUpdateChannel(channel)
                case .removed:
                    CoreDataService.shared.deleteChannel(channel)
                }
            }
        }
    }
    
    func getMessages(fromChannel channel: Channel) {
        let messagesReference = channelsReference.document(channel.identifier).collection(Constants.messagesCollectionPath)
        
        messagesReference.addSnapshotListener { snapshot, error in
            if let error = error {
                // TODO add alert?
                print(error.localizedDescription)
                return
            }
            
            var messages: [Message] = []
            
            snapshot?.documentChanges.forEach {
                let document = $0.document
                guard let message = Message(identifier: document.documentID, data: document.data()) else { return }
                
                if $0.type == .added {
                    messages.append(message)
                }
            }
            
            CoreDataService.shared.insertMessages(messages, toChannel: channel)
        }
    }
    
    func sendMessage(withContent content: String, byPath path: String) {
        guard let id = Constants.myID else { return }
        let documentsReference = channelsReference.document(path)
        let message = Message(content: content, created: Date(), senderID: id, senderName: userName, identifier: "firebase_generates")
        
        documentsReference.collection(Constants.messagesCollectionPath).addDocument(data: message.toDict)
        documentsReference.updateData(["lastMessage": content, "lastActivity": Timestamp(date: Date())])
    }
    
    func addChannel(withName name: String) {
        channelsReference.addDocument(data: ["name": name, "lastActivity": Timestamp(date: Date())])
    }
    
    func deleteChannel(byPath path: String) {
        channelsReference.document(path).delete()
    }
}
