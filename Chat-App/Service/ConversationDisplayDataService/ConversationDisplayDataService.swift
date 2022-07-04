//
//  ConversationDisplayDataService.swift
//  Chat-App
//
//  Created by Станислав on 03.07.2022.
//

protocol ConversationDisplayDataService {
    
    func getDisplayData(from data: Message) -> ConversationDisplayData
}
