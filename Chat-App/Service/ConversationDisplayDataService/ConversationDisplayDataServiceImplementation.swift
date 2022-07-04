//
//  ConversationDisplayDataServiceImplementation.swift
//  Chat-App
//
//  Created by Станислав on 03.07.2022.
//

import Foundation

class ConversationDisplayDataServiceImplementation: ConversationDisplayDataService {
    
    private lazy var dateFormatter = DateFormatter()
    
    func getDisplayData(from data: Message) -> ConversationDisplayData {
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
        
        let displayData = ConversationDisplayData(name: name, message: message, date: stringDate, senderID: senderID)
        
        return displayData
    }
}
