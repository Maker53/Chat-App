//
//  SetupUI.swift
//  Chat-App
//
//  Created by Станислав on 07.03.2022.
//

import UIKit

extension ConversationListViewController {
    // MARK: - Setup Conversation List Table View
    func setupConversationListTableView() {
        view.addSubview(conversationListTableView)
        
        title = "Tinkoff Chat"
        
        NSLayoutConstraint.activate([
            conversationListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            conversationListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            conversationListTableView.topAnchor.constraint(equalTo: view.topAnchor),
            conversationListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        conversationListTableView.translatesAutoresizingMaskIntoConstraints = false
    }
}

