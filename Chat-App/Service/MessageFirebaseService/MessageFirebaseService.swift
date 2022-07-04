//
//  MessageFirebaseService.swift
//  Chat-App
//
//  Created by Станислав on 03.07.2022.
//

protocol MessageFirebaseService {
    
    func listeningMessages(fromChannel channel: Channel)
    func createMessage(withContent content: String, byChannel channel: Channel)
}
