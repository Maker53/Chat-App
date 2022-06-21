//
//  CoreDataStack.swift
//  Chat-App
//
//  Created by Станислав on 21.06.2022.
//

import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()
    let service = CoreDataService()
    
    private init() {}
    
    func fetchChannels() -> [Channel] {
        let dbChannels: [ChannelDB] = service.fetchData()
        var channels: [Channel] = []
        
        dbChannels.forEach {
            let channel = Channel(dbModel: $0)
            channels.append(channel)
        }
        
        channels.sort { $0.lastActivity > $1.lastActivity }
        
        return channels
    }
    
    func fetchMessages(formChannel channel: Channel) -> [Message] {
        guard let dbChannel = fetchDBChannel(channel: channel) else { return [] }
        guard let dbMessages = dbChannel.messages?.allObjects as? [MessageDB] else { return [] }
        var messages: [Message] = []
        
        dbMessages.forEach {
            let message = Message(dbModel: $0)
            messages.append(message)
        }
        
        messages.sort { $0.created < $1.created }
        
        return messages
    }
    
    func saveChannels(_ channels: [Channel]) {
        service.peformSave { context in
            channels.forEach { channel in
                let dbChannel = ChannelDB(context: context)
                
                dbChannel.identifier = channel.identifier
                dbChannel.name = channel.name
                dbChannel.lastActivity = channel.lastActivity
                dbChannel.lastMessage = channel.lastMessage
            }
        }
    }
    
    func saveMessages(_ messages: [Message], fromChannel channel: Channel) {
        service.peformSave { context in
            let dbChannel = ChannelDB(context: context)
            
            dbChannel.identifier = channel.identifier
            dbChannel.name = channel.name
            dbChannel.lastMessage = channel.lastMessage
            dbChannel.lastActivity = channel.lastActivity
            
            var dbMessages: [MessageDB] = []
            
            messages.forEach { message in
                let dbMessage = MessageDB(context: context)
                
                dbMessage.content = message.content
                dbMessage.created = message.created
                dbMessage.senderID = message.senderID
                dbMessage.senderName = message.senderName
                
                dbMessages.append(dbMessage)
                dbChannel.addToMessages(dbMessage)
            }
        }
    }
    
    private func fetchDBChannel(channel: Channel) -> ChannelDB? {
        let dbChannels: [ChannelDB] = service.fetchData()
        guard let dbChannel = dbChannels.filter({ $0.identifier == channel.identifier }).first else { return nil }
        
        return dbChannel
    }
}
