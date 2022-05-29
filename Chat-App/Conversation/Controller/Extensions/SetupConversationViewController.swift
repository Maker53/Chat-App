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
        view.backgroundColor = .systemBackground
        
        messagesListTableView.dataSource = self
        messagesListTableView.rowHeight = UITableView.automaticDimension
        messagesListTableView.estimatedRowHeight = 62
        messagesListTableView.translatesAutoresizingMaskIntoConstraints = false
        messagesListTableView.separatorStyle = .none
        messagesListTableView.allowsSelection = false
        
        inputMessageTextField.borderStyle = .roundedRect
        inputMessageTextField.translatesAutoresizingMaskIntoConstraints = false
        
        if let buttonImage = UIImage(systemName: "arrow.up") {
            sendMessageButton = .systemButton(with: buttonImage, target: self, action: #selector(sendMessage))
        }
        sendMessageButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(messagesListTableView)
        view.addSubview(inputMessageTextField)
        view.addSubview(sendMessageButton)
        
        inputMessageTextField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        NSLayoutConstraint.activate([
            inputMessageTextField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            inputMessageTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            
            sendMessageButton.leadingAnchor.constraint(equalTo: inputMessageTextField.trailingAnchor, constant: 10),
            sendMessageButton.centerYAnchor.constraint(equalTo: inputMessageTextField.centerYAnchor),
            sendMessageButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
            messagesListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            messagesListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            messagesListTableView.topAnchor.constraint(equalTo: view.topAnchor),
            messagesListTableView.bottomAnchor.constraint(equalTo: inputMessageTextField.topAnchor)
        ])
    }
    
    @objc private func sendMessage() {
        
    }
}

