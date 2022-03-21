//
//  ConversationListDisplayDataParser.swift
//  Chat-App
//
//  Created by Станислав on 19.03.2022.
//

import Foundation

class ConversationListDisplayDataParser {
    
    static let shared = ConversationListDisplayDataParser()
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "en_RU")
        
        return dateFormatter
    }()
    
    private init() {}
    
    func getDisplayData(from data: User) -> DisplayData {
        let name = data.fullname
        var message = data.messages.last?.message
        var date = data.messages.last?.date
        let online = data.isOnline
        var hasUnreadMessage = data.messages.last?.hasUnreadMessages ?? false
        var dateString = ""
        
        if message == nil {
            date = nil
            hasUnreadMessage = false
            message = "No messages yet"
        }
        
        if let date = date {
            if Calendar.current.isDateInToday(date) {
                dateFormatter.setLocalizedDateFormatFromTemplate("HH:mm")
            } else {
                dateFormatter.setLocalizedDateFormatFromTemplate("dd MMM")
            }
            
            dateString = dateFormatter.string(from: date)
        } else {
            dateString = ""
        }
        
        let displayData = DisplayData(
            name: name,
            message: message,
            date: dateString,
            online: online,
            hasUnreadMessages: hasUnreadMessage
        )
        
        return displayData
    }
}

class DisplayData {
    
    var name: String?
    var message: String?
    var date: String?
    var online: Bool
    var hasUnreadMessages: Bool
    
    init(name: String?, message: String?, date: String?, online: Bool, hasUnreadMessages: Bool) {
        self.name = name
        self.message = message
        self.date = date
        self.online = online
        self.hasUnreadMessages = hasUnreadMessages
    }
}
