//
//  ConversationsListDisplayDataParser.swift
//  Chat-App
//
//  Created by Станислав on 19.03.2022.
//

import Foundation

struct DisplayData {
    let name: String
    let message: String?
    let date: String?
}

class ConversationsListDisplayDataParser {
    private lazy var dateFormatter = DateFormatter()
    
    func getDisplayData(from data: Channel) -> DisplayData {
        let name = data.name
        var message = data.lastMessage
        let date = data.lastActivity
        let stringDate: String
        
        if message == nil {
            message = "No messages yet"
        }
        
        if Calendar.current.isDateInToday(date) {
            dateFormatter.setLocalizedDateFormatFromTemplate("HH:mm")
        } else {
            dateFormatter.setLocalizedDateFormatFromTemplate("dd MMM")
        }
        
        stringDate = dateFormatter.string(from: date)
        
        let displayData = DisplayData(name: name, message: message, date: stringDate)
        
        return displayData
    }
}
