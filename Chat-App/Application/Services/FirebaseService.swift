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
    
    func getChannels(completion: @escaping ([Channel]) -> Void) {
        channelsReference.addSnapshotListener { snapshot, error in
            if let error = error {
                // TODO add alert?
                print(error.localizedDescription)
                return
            }
            
            var channels: [Channel] = []
            
            snapshot?.documents.forEach {
                let identifier = $0.documentID
                let data = $0.data()
                guard let channel = Channel(identifier: identifier, data: data) else { return }
                
                channels.append(channel)
            }
            
            channels.sort { $0.lastActivity > $1.lastActivity }
            
            CoreDataStack.shared.saveChannels(channels)
            completion(channels)
        }
    }
    
    func getMessages(fromChannel channel: Channel, completion: @escaping ([Message]) -> Void) {
        let messagesReference = channelsReference.document(channel.identifier).collection(Constants.messagesCollectionPath)
        
        messagesReference.addSnapshotListener { snapshot, error in
            if let error = error {
                // TODO add alert?
                print(error.localizedDescription)
                return
            }
            
            var messages: [Message] = []
            
            snapshot?.documents.forEach {
                guard let message = Message(data: $0.data()) else { return }
                messages.append(message)
            }
            
            messages.sort { $0.created < $1.created }
            
            CoreDataStack.shared.saveMessages(messages, fromChannel: channel)
            completion(messages)
        }
    }
    
    func sendMessage(withContent content: String, byPath path: String) {
        guard let id = Constants.myID else { return }
        let documentsReference = channelsReference.document(path)
        let message = Message(content: content, created: Date(), senderID: id, senderName: userName)
        
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
