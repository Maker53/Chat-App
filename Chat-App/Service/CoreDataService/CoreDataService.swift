//
//  CoreDataService.swift
//  Chat-App
//
//  Created by Станислав on 03.07.2022.
//

protocol CoreDataService {
    
    func insertOrUpdateChannel(_ channel: Channel)
    func insertMessages(_ messages: [Message], toChannel channel: Channel)
    func deleteChannel(_ channel: Channel)
}
