//
//  User.swift
//  Chat-App
//
//  Created by Станислав on 07.03.2022.
//

import Foundation

struct User {
    let fullname: String
    let isOnline: Bool
    let messages: [Message]
    
    // MARK: - Mock
    static let mock = [
        User(
            fullname: "Maks Petrov",
            isOnline: true,
            messages: [
                Message(message: "Hello!!!", date: Date(), hasUnreadMessages: true)
            ]
        ),
        User(
            fullname: "Artyom Federov",
            isOnline: true,
            messages: [
                Message(message: "Have a nice day", date: Date(), hasUnreadMessages: false)
            ]
        ),
        User(
            fullname: "Ivan Petrov",
            isOnline: false,
            messages: [
                Message(message: "How are u?", date: Date(), hasUnreadMessages: true)
            ]
        ),
        User(
            fullname: "Artyom Bolshakov",
            isOnline: false,
            messages: [
                Message(message: "I'm fine", date: Date(), hasUnreadMessages: false),
                Message(message: nil, date: nil, hasUnreadMessages: false)
            ]
        ),
        User(
            fullname: "David Frank",
            isOnline: false,
            messages: []
        )
    ]
}

struct Message {
    
    let message: String?
    let date: Date?
    let hasUnreadMessages: Bool
}
