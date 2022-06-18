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
    
    // MARK: - Private Methods
    
    private lazy var channelsReference = Firestore.firestore().collection("channels")
    private var userName: String {
        let name = "Test name"
        
//        StorageManager.shared.fetchViaGCD(from: Constants.userInfoFileNameForSave) { name = $0?.name ?? "" }
        
        return name
    }
    
    // MARK: - Private initialiser
    
    private init() {}
    
    // MARK: - Public Methods
    
    func getChannels(completion: @escaping ([Channel]) -> Void) {
        var channels: [Channel] = []
        
        channelsReference.addSnapshotListener { snapshot, error in
            guard error == nil else {
                // TODO add alert?
                print(error?.localizedDescription)
                return
            }
            
            channels = []
            
            snapshot?.documents.forEach {
                let channel: Channel
                let identifier = $0.documentID
                guard let name = $0.data()["name"] as? String else { return }
                guard let lastActivity = $0.data()["lastActivity"] as? Timestamp else { return }
                
                if let lastMessage = $0.data()["lastMessage"] as? String {
                    channel = Channel(identifier: identifier, name: name, lastMessages: lastMessage, lastActivity: lastActivity.dateValue())
                } else {
                    channel = Channel(identifier: identifier, name: name, lastMessages: nil, lastActivity: lastActivity.dateValue())
                }
                
                channels.append(channel)
            }
            
            channels.sort { $0.lastActivity > $1.lastActivity }
            completion(channels)
        }
    }
    
    func getMessages(byPath path: String, completion: @escaping ([Message]) -> Void) {
        let messagesReference = channelsReference.document(path).collection("messages")
        var messages: [Message] = []
        
        messagesReference.addSnapshotListener { snapshot, error in
            guard error == nil else {
                // TODO add alert?
                print(error?.localizedDescription)
                return
            }
            
            messages = []
            
            snapshot?.documents.forEach {
                let message: Message
                
                guard let senderID = $0.data()["senderID"] as? String else { return }
                guard let senderName = $0.data()["senderName"] as? String else { return }
                guard let content = $0.data()["content"] as? String else { return }
                guard let created = $0.data()["created"] as? Timestamp else { return }
                
                message = Message(content: content, created: created.dateValue(), senderID: senderID, senderName: senderName)
                messages.append(message)
            }
            
            messages.sort { $0.created < $1.created }
            completion(messages)
        }
    }
    
    func sendMessage(withContent content: String, byPath path: String) {
        guard let id = Constants.myID else { return }
        let message = Message(content: content, created: Date(), senderID: id, senderName: userName)
        
        channelsReference.document(path).collection("messages").addDocument(data: message.toDict)
        channelsReference.document(path).updateData(["lastMessage": content, "lastActivity": Timestamp(date: Date())])
    }
    
    func addChannel(withName name: String) {
        channelsReference.addDocument(data: ["name": name, "lastActivity": Timestamp(date: Date()), "lastMessage": "No messages yet"])
    }
    
    func deleteChannel(byPath path: String) {
        channelsReference.document(path).delete()
    }
}
