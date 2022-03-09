//
//  SetupConversationTableView.swift
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
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray
        let image = UIImage(systemName: "person.fill")
        imageView.image = image
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: imageView)
        
        conversationListTableView.rowHeight = UITableView.automaticDimension
        conversationListTableView.estimatedRowHeight = 56
        
        NSLayoutConstraint.activate([
            conversationListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            conversationListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            conversationListTableView.topAnchor.constraint(equalTo: view.topAnchor),
            conversationListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        conversationListTableView.translatesAutoresizingMaskIntoConstraints = false
    }
}
