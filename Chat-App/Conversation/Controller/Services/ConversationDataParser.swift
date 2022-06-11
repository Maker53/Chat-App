//
//  ConversationDataParser.swift
//  Chat-App
//
//  Created by Станислав on 11.06.2022.
//

import Foundation

struct DisplayConversationData {
    let name: String
    let message: String
    let date: String
    let senderID: String
}

class ConversationDisplayDataParser {
    private lazy var dateFormatter = DateFormatter()
    
    func getDisplayData(from data: Message) -> DisplayConversationData {
        let name = data.senderName
        let message = data.content
        let date = data.created
        let senderID = data.senderID
        let stringDate: String
        
        if Calendar.current.isDateInToday(date) {
            dateFormatter.setLocalizedDateFormatFromTemplate("HH:mm")
        } else {
            dateFormatter.setLocalizedDateFormatFromTemplate("dd MMM")
        }
        
        stringDate = dateFormatter.string(from: date)
        
        let displayData = DisplayConversationData(name: name, message: message, date: stringDate, senderID: senderID)
        
        return displayData
    }
}
