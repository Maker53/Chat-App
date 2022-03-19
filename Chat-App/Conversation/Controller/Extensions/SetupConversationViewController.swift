//
//  SetupConversationViewController.swift
//  Chat-App
//
//  Created by Станислав on 08.03.2022.
//

import UIKit

// MARK: - Setup Conversation View Controller
extension ConversationViewController {
    
    func setupConversationViewController() {
        view.addSubview(messagesListTableView)
        
        messagesListTableView.rowHeight = UITableView.automaticDimension
        messagesListTableView.estimatedRowHeight = 56
        
        NSLayoutConstraint.activate([
            messagesListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            messagesListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            messagesListTableView.topAnchor.constraint(equalTo: view.topAnchor),
            messagesListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        messagesListTableView.translatesAutoresizingMaskIntoConstraints = false
        messagesListTableView.separatorStyle = .none
        messagesListTableView.allowsSelection = false
    }
}

