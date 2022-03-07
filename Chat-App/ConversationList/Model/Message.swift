//
//  Message.swift
//  Chat-App
//
//  Created by Станислав on 07.03.2022.
//

import Foundation

struct Message {
    
    let fullname: String
    let message: String
    let date: Date
    
    // MARK: - Mock
    static let mock = [
        Message(fullname: "Maks Petrov", message: "Hello!!!", date: Date()),
        Message(fullname: "Artyom Federov", message: "Have a nice day", date: Date())
    ]
}
