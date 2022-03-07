//
//  Message.swift
//  Chat-App
//
//  Created by Станислав on 07.03.2022.
//

import Foundation

struct Status {
    let online: Bool
    let message: [Message]
    
    // MARK: - Mock
    static let mock = [
        Status(
            online: true,
            message: [
                Message(
                    fullName: "Maks Petrov",
                    message: "Hello!!!",
                    date: Date(),
                    hasUnreadMessages: true
                ),
                Message(
                    fullName: "Artyom Federov",
                    message: "Have a nice day",
                    date: Date(),
                    hasUnreadMessages: false
                )
            ]
        ),
        Status(
            online: false,
            message: [
                Message(
                    fullName: "Ivan Petrov",
                    message: "How are u?",
                    date: Date(),
                    hasUnreadMessages: true
                ),
                Message(
                    fullName: "Artyom Bolshakov",
                    message: "I'm fine",
                    date: Date(),
                    hasUnreadMessages: false
                )
            ]
        )
    ]
}

struct Message {
    
    let fullName: String
    let message: String
    let date: Date
    let hasUnreadMessages: Bool
}
