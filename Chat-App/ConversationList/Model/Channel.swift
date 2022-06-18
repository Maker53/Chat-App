//
//  User.swift
//  Chat-App
//
//  Created by Станислав on 07.03.2022.
//

import FirebaseFirestore

struct Channel {
    let identifier: String
    let name: String
    let lastMessages: String?
    let lastActivity: Date
    
    init?(identifier: String, data: [String: Any]) {
        self.identifier = identifier
        
        guard let name = data["name"] as? String else { return nil }
        self.name = name
        self.lastMessages = data["lastMessage"] as? String
        guard let date = data["lastActivity"] as? Timestamp else { return nil }
        self.lastActivity = date.dateValue()
    }
}
