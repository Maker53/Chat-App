//
//  SetupConversationViewController.swift
//  Chat-App
//
//  Created by Станислав on 08.03.2022.
//

import UIKit
import FirebaseFirestore

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
        let tap = UITapGestureRecognizer(target: self, action: #selector(touch))
        messagesListTableView.addGestureRecognizer(tap)
        
        inputMessageTextField.borderStyle = .roundedRect
        inputMessageTextField.translatesAutoresizingMaskIntoConstraints = false
        inputMessageTextField.delegate = self
        
        NotificationCenter.default.addObserver(
            forName: UITextField.textDidChangeNotification,
            object: inputMessageTextField,
            queue: OperationQueue.main)
        { [weak self] _ in
            guard let self = self else { return }
            guard let inputText = self.inputMessageTextField.text else { return }
            let textIsNotEmpty = !inputText.isEmpty
            
            self.sendMessageButton.isEnabled = textIsNotEmpty
        }
        
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
    
    @objc func sendMessage() {
        guard let content = inputMessageTextField.text, !content.isEmpty else { return }
        
        FirebaseService.shared.sendMessage(withContent: content, byPath: channelID)
    }
    
    @objc private func touch() {
        view.endEditing(true)
    }
}

