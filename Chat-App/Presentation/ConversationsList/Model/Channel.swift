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
    let lastMessage: String?
    let lastActivity: Date
}

extension Channel {
    
    init?(dbModel: ChannelDB) {
        guard let identifier = dbModel.identifier else { return nil }
        guard let name = dbModel.name else { return nil }
        
        self.identifier = identifier
        self.name = name
        self.lastMessage = dbModel.lastMessage
        self.lastActivity = dbModel.lastActivity ?? Date()
    }
    
    init?(identifier: String, data: [String: Any]) {
        self.identifier = identifier
        
        guard let name = data["name"] as? String else { return nil }
        self.name = name
        self.lastMessage = data["lastMessage"] as? String
        guard let date = data["lastActivity"] as? Timestamp else { return nil }
        self.lastActivity = date.dateValue()
    }
}
