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
    let messages: [Message]?
    
    static let mock = mockObject
}

struct Message {
    
    let message: String
    let date: Date
    let hasUnreadMessages: Bool
}

// MARK: - Mock
private let mockObject = [
    User(
        fullname: "Verona Bradtke",
        isOnline: true,
        messages: [
            Message(
                message: """
                        Hi there, this is Verona from SparksServices.
                        I saw you signed up for a free trial on our website.
                        """,
                date: Date(timeInterval: -20_000, since: Date()),
                hasUnreadMessages: true
            )
        ]
    ),
    User(
        fullname: "Mr. Emmitt Kshlerin ",
        isOnline: false,
        messages: [
            Message(
                message: "I saw you signed up for a free trial on our website.",
                date: Date(timeInterval: -30_500, since: Date()),
                hasUnreadMessages: false
            )
        ]
    ),
    User(
        fullname: "Dr. Chad Klocko",
        isOnline: true,
        messages: [
            Message(
                message: "Can we set up a time for a phone call?",
                date: Date(timeInterval: -95_000, since: Date()),
                hasUnreadMessages: true
            ),
            Message(
                message: "Have a nice day",
                date: Date(timeInterval: -90_000, since: Date()),
                hasUnreadMessages: false
            )
        ]
    ),
    User(
        fullname: "Gardner Sauer",
        isOnline: false,
        messages: [
            Message(
                message: "Have a nice day",
                date: Date(timeInterval: -192_000, since: Date()),
                hasUnreadMessages: true
            ),
            Message(
                message: "Can we set up a time for a phone call?",
                date: Date(timeInterval: -190_000, since: Date()),
                hasUnreadMessages: true
            )
        ]
    ),
    User(
        fullname: "Paula Weber",
        isOnline: true,
        messages: [
            Message(
                message: "",
                date: Date(timeInterval: -74_000, since: Date()),
                hasUnreadMessages: true
            )
        ]
    ),
    User(
        fullname: "David Frank",
        isOnline: false,
        messages: [
            Message(
                message: "",
                date: Date(timeInterval: -70_000, since: Date()),
                hasUnreadMessages: false
            )
        ]
    ),
    User(
        fullname: "Rylan Kozey",
        isOnline: true,
        messages: [
            Message(
                message: "thank you for taking the time for a call today",
                date: Date(),
                hasUnreadMessages: true
            )
        ]
    ),
    User(
        fullname: "Lauriane Dickinson",
        isOnline: false,
        messages: [
            Message(
                message: "Thank you for taking the time for a call today!!!",
                date: Date(),
                hasUnreadMessages: true
            )
        ]
    ),
    User(
        fullname: "Dorian Jacobi",
        isOnline: true,
        messages: nil
    ),
    User(
        fullname: "Amir Hessel",
        isOnline: false,
        messages: []
    ),
    User(
        fullname: "Michael Muller",
        isOnline: true,
        messages: [
            Message(
                message: "We have an update on your custom car order!",
                date: Date(timeInterval: -70_000_000, since: Date()),
                hasUnreadMessages: false
            )
        ]
    ),
    User(
        fullname: "Ms. Sydnie Jast I",
        isOnline: false,
        messages: [
            Message(
                message: "Next up is the new paint",
                date: Date(timeInterval: -7_000_000_000, since: Date()),
                hasUnreadMessages: true
            )
        ]
    ),
    User(
        fullname: "Dr. Cleta Kihn",
        isOnline: true,
        messages: [
            Message(
                message: "You can view them here: http://toriskitchen.com/",
                date: Date(timeInterval: -80_000, since: Date()),
                hasUnreadMessages: true
            )
        ]
    ),
    User(
        fullname: "Jake McGlynn",
        isOnline: false,
        messages: [
            Message(
                message: "Congrats on your latest loan deal!",
                date: Date(timeInterval: -17_000, since: Date()),
                hasUnreadMessages: true
            )
        ]
    ),
    User(
        fullname: "Juston Cremin",
        isOnline: true,
        messages: [
            Message(
                message: "You’re almost done buying",
                date: Date(timeInterval: -10_000, since: Date()),
                hasUnreadMessages: false
            )
        ]
    ),
    User(
        fullname: "Ebony Kreiger",
        isOnline: false,
        messages: [
            Message(
                message: "Happy Monday!",
                date: Date(timeInterval: -11_000, since: Date()),
                hasUnreadMessages: false
            )
        ]
    ),
    User(
        fullname: "Elaina O'Reilly",
        isOnline: true,
        messages: [
            Message(
                message: "",
                date: Date(timeInterval: -140_000, since: Date()),
                hasUnreadMessages: true
            )
        ]
    ),
    User(
        fullname: "Raven Berge",
        isOnline: false,
        messages: [
            Message(
                message: "",
                date: Date(timeInterval: -7_000, since: Date()),
                hasUnreadMessages: true
            )
        ]
    ),
    User(
        fullname: "Very-very looooooooooooooooooooong name",
        isOnline: true,
        messages: [
            Message(
                message: "Hi!",
                date: Date(timeInterval: -110_110, since: Date()),
                hasUnreadMessages: false
            )
        ]
    ),
    User(
        fullname: "Looooooooooooooooooooooooooooong name",
        isOnline: false,
        messages: [
            Message(
                message: "",
                date: Date(timeInterval: -32_000, since: Date()),
                hasUnreadMessages: true
            )
        ]
    )
]
