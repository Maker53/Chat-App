//
//  Message.swift
//  Chat-App
//
//  Created by Станислав on 18.06.2022.
//

import FirebaseFirestore

struct Message {
    
    let content: String
    let created: Date
    let senderID: String
    let senderName: String
    let identifier: String
}

extension Message {
    
    init?(dbModel: MessageDB) {
        guard let content = dbModel.content else { return nil }
        guard let created = dbModel.created else { return nil }
        guard let senderID = dbModel.senderID else { return nil }
        guard let senderName = dbModel.senderName else { return nil }
        guard let identifier = dbModel.identifier else { return nil }
        
        self.content = content
        self.created = created
        self.senderID = senderID
        self.senderName = senderName
        self.identifier = identifier
    }
    
    init?(identifier: String, data: [String: Any]) {
        guard let senderID = data["senderID"] as? String else { return nil }
        guard let senderName = data["senderName"] as? String else { return nil }
        guard let content = data["content"] as? String else { return nil }
        guard let date = data["created"] as? Timestamp else { return nil }
        
        self.content = content
        self.created = date.dateValue()
        self.senderID = senderID
        self.senderName = senderName
        self.identifier = identifier
    }
    
    var toDict: [String: Any] {
        ["content": content,
         "created": Timestamp(date: created),
         "senderID": senderID,
         "senderName": senderName]
    }
}
