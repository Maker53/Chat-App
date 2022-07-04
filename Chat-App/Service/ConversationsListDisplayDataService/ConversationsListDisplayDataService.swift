//
//  ConversationsListDisplayDataService.swift
//  Chat-App
//
//  Created by Станислав on 03.07.2022.
//

protocol ConversationsListDisplayDataService {
    
    func getDisplayData(from data: Channel) -> ConversationsListDisplayData
}
