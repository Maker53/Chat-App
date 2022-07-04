//
//  CoreDataServiceImplementation.swift
//  Chat-App
//
//  Created by Станислав on 03.07.2022.
//

import CoreData

class CoreDataServiceImplementation: CoreDataService {
    
    private let coreDataStack = CoreAssembly.coreDataStack
    
    func insertOrUpdateChannel(_ channel: Channel) {
        let channelDB = fetchDBChannelByID(channel.identifier)
        
        if let channelDB = channelDB {
            coreDataStack.performSave { _ in
                channelDB.identifier = channel.identifier
                channelDB.name = channel.name
                channelDB.lastMessage = channel.lastMessage
                channelDB.lastActivity = channel.lastActivity
            }
        } else {
            coreDataStack.performSave { context in
                let channelDB = ChannelDB(context: context)
                
                channelDB.identifier = channel.identifier
                channelDB.name = channel.name
                channelDB.lastMessage = channel.lastMessage
                channelDB.lastActivity = channel.lastActivity
            }
        }
    }
    
    func insertMessages(_ messages: [Message], toChannel channel: Channel) {
        guard !messages.isEmpty else { return }
        guard let channelDB = fetchDBChannelByID(channel.identifier) else { return }
        
        coreDataStack.performSave { [weak self] context in
            messages.forEach { self?.insertMessage($0, toChannelDB: channelDB, inContext: context) }
        }
    }
    
    func deleteChannel(_ channel: Channel) {
        let channelDB = fetchDBChannelByID(channel.identifier)
        guard let channelDB = channelDB else { return }
        
        coreDataStack.deleteData(channelDB)
    }
    
    // MARK: - Private Methods
    
    private func insertMessage(_ message: Message, toChannelDB channelDB: ChannelDB, inContext context: NSManagedObjectContext) {
        guard fetchDBMessageByID(message.identifier) == nil else { return }
        let messageDB = MessageDB(context: context)
        
        messageDB.content = message.content
        messageDB.senderID = message.senderID
        messageDB.senderName = message.senderName
        messageDB.created = message.created
        messageDB.identifier = message.identifier
        
        channelDB.addToMessages(messageDB)
    }
    
    private func fetchDBChannelByID(_ identifier: String) -> ChannelDB? {
        let format = #keyPath(ChannelDB.identifier) + " == %@"
        let predicate = NSPredicate(format: format, identifier)
        let dbChannels: [ChannelDB] = coreDataStack.fetchData(inContext: coreDataStack.writeContext, withPredicate: predicate)
        
        return dbChannels.first
    }
    
    private func fetchDBMessageByID(_ id: String) -> MessageDB? {
        let format = #keyPath(MessageDB.identifier) + " == %@"
        let predicate = NSPredicate(format: format, id)
        let dbMessages: [MessageDB] = coreDataStack.fetchData(inContext: coreDataStack.readContext, withPredicate: predicate)
        
        return dbMessages.first
    }
}
