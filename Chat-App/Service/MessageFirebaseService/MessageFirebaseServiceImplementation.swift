//
//  MessageFirebaseServiceImplementation.swift
//  Chat-App
//
//  Created by Станислав on 03.07.2022.
//

import FirebaseFirestore

class MessageFirebaseServiceImplementation: MessageFirebaseService {
    
    // MARK: - Services
    
    private let coreDataService = ServiceAssembly.coreDataService
    private let gcdService = ServiceAssembly.gcdService
    private var firebaseService = CoreAssembly.firebaseService
    
    // MARK: - Reference
    
    private var channelsReference: CollectionReference {
        firebaseService.db.collection(Constants.channelsCollectionPath)
    }
    
    // MARK: - Private Property
    
    private var userName: String!
    
    // MARK: - Initializer
    
    init() {
        gcdService.fetchData { data in
            self.userName = data.name ?? ""
        }
    }
    
    // MARK: - Public Methods
    
    func listeningMessages(fromChannel channel: Channel) {
        let messageReference = getMessagesReference(fromChannel: channel)
        
        firebaseService.collectionReference = messageReference
        
        firebaseService.addSnapshotListener { [weak self] result in
            switch result {
            case .success(let documents):
                var messages: [Message] = []
                
                documents.forEach { documentsChange in
                    let document = documentsChange.document
                    guard let message = Message(identifier: document.documentID, data: document.data()) else { return }
                    
                    if documentsChange.type == .added {
                        messages.append(message)
                    }
                }
                
                self?.coreDataService.insertMessages(messages, toChannel: channel)
            case .failure(let error):
                print("Fetch messages error: ", error.localizedDescription)
            }
        }
    }
    
    func createMessage(withContent content: String, byChannel channel: Channel) {
        let messageReference = getMessagesReference(fromChannel: channel)
        guard let id = Constants.myID else { return }
        
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            guard let self = self else { return }
            let message = Message(content: content, created: Date(), senderID: id, senderName: self.userName, identifier: Constants.messageIdentifier)
            
            self.firebaseService.collectionReference = messageReference
            
            self.firebaseService.addDocument(data: message.toDict) { error in
                if let error = error {
                    print("Message not created: ", error.localizedDescription)
                }
            }
            
            self.firebaseService.collectionReference = self.channelsReference
            
            self.firebaseService.updateDocument(
                identifier: channel.identifier,
                data: ["lastMessage": content, "lastActivity": Timestamp(date: Date())]
            ) { error in
                if let error = error {
                    print("Channels not updated with new message: ", error.localizedDescription)
                }
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func getMessagesReference(fromChannel channel: Channel) -> CollectionReference {
        channelsReference.document(channel.identifier).collection(Constants.messagesCollectionPath)
    }
}
