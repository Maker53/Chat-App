//
//  ChannelFirebaseService.swift
//  Chat-App
//
//  Created by Станислав on 03.07.2022.
//

protocol ChannelFirebaseService {
    
    func listeningChannels()
    func createChannel(name: String)
    func deleteChannel(_ channel: Channel)
}
