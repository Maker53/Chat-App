//
//  User.swift
//  Chat-App
//
//  Created by Станислав on 07.03.2022.
//

import Foundation

struct Channel {
    let identifier: String
    let name: String
    let lastMessages: String?
    let lastActivity: Date?
}

struct Message {
    let content: String
    let created: Date
    let senderID: String
    let senderName: Bool
}
