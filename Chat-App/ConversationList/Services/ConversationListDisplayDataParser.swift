//
//  ConversationListDisplayDataParser.swift
//  Chat-App
//
//  Created by Станислав on 19.03.2022.
//

import Foundation

class ConversationListDisplayDataParser {
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "en_RU")
        
        return dateFormatter
    }()
    
    func getDisplayData(from data: Channel) -> DisplayData {
        let name = data.name
        var message = data.lastMessages
        let date = data.lastActivity
        var dateToString = ""
        
        if message == nil {
            message = "No messages yet"
        }
        
        if Calendar.current.isDateInToday(date) {
            dateFormatter.setLocalizedDateFormatFromTemplate("HH:mm")
        } else {
            dateFormatter.setLocalizedDateFormatFromTemplate("dd MMM")
        }
        
        dateToString = dateFormatter.string(from: date)
        
        let displayData = DisplayData(name: name, message: message, date: dateToString)
        
        return displayData
    }
}

struct DisplayData {
    let name: String
    let message: String?
    let date: String?
}
