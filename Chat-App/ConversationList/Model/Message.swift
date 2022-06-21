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
}

extension Message {
    init(dbModel: MessageDB) {
        self.content = dbModel.content ?? ""
        self.created = dbModel.created ?? Date()
        self.senderID = dbModel.senderID ?? ""
        self.senderName = dbModel.senderName ?? ""
    }
    
    init?(data: [String: Any]) {
        guard let senderID = data["senderID"] as? String else { return nil }
        guard let senderName = data["senderName"] as? String else { return nil }
        guard let content = data["content"] as? String else { return nil }
        guard let date = data["created"] as? Timestamp else { return nil }
        
        self.content = content
        self.created = date.dateValue()
        self.senderID = senderID
        self.senderName = senderName
    }
    
    var toDict: [String: Any] {
        ["content": content,
         "created": Timestamp(date: created),
         "senderID": senderID,
         "senderName": senderName]
    }
}
