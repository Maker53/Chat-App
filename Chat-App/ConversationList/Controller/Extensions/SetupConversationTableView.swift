//
//  SetupConversationTableView.swift
//  Chat-App
//
//  Created by Станислав on 07.03.2022.
//

import UIKit
import FirebaseFirestore

extension ConversationListViewController {
    
    // MARK: - Setup Conversation List Table View
    func setupConversationListTableView() {
        view.addSubview(conversationListTableView)
        
        title = "Channels"
        
        conversationListTableView.dataSource = self
        conversationListTableView.delegate = self
        
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButtonPressed))
        let createChannelButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(newChannelButtonPressed))
        
        editButton.tintColor = .systemGray
        createChannelButton.tintColor = .systemGray
        
        navigationItem.rightBarButtonItems = [createChannelButton, setupProfileBarButton()]
        navigationItem.leftBarButtonItems = [editButton, setupSettingsBarButton()]
        
        conversationListTableView.translatesAutoresizingMaskIntoConstraints = false
        conversationListTableView.rowHeight = UITableView.automaticDimension
        conversationListTableView.estimatedRowHeight = 52
        
        NSLayoutConstraint.activate([
            conversationListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            conversationListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            conversationListTableView.topAnchor.constraint(equalTo: view.topAnchor),
            conversationListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - Setup Custom BarButtonItems
    private func setupProfileBarButton() -> UIBarButtonItem {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "person.fill")
        
        button.setImage(image, for: .normal)
        button.tintColor = .systemGray
        
        button.addTarget(self, action: #selector(profileButtonPressed), for: .touchUpInside)
        
        let barItem = UIBarButtonItem(customView: button)
        return barItem
    }
    
    private func setupSettingsBarButton() -> UIBarButtonItem {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "gear")
        
        button.setImage(image, for: .normal)
        button.tintColor = .systemGray
        
        button.addTarget(self, action: #selector(settingsButtonPressed), for: .touchUpInside)
        
        let barItem = UIBarButtonItem(customView: button)
        return barItem
    }
    
    // MARK: - Target Actions
    @objc private func profileButtonPressed() {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ProfileVC")
        guard let profileViewController = viewController as? ProfileViewController else { return }
        profileViewController.userProfileInfo = self.userProfileInfo
        
        let navigationController = UINavigationController(rootViewController: profileViewController)
        present(navigationController, animated: true)
    }
    
    @objc private func settingsButtonPressed() {
        let themesViewController = ThemesViewController()
        navigationController?.pushViewController(themesViewController, animated: true)
    }
    
    @objc private func newChannelButtonPressed() {
        let alert = UIAlertController(title: "Add new channel", message: nil, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let createAction = UIAlertAction(title: "Create", style: .default) { _ in
            let name = alert.textFields![0].text!
            FirebaseService.shared.addChannel(withName: name)
        }
        
        createAction.isEnabled = false
        
        alert.addTextField { textField in
            textField.placeholder = "Channel name"
            
            NotificationCenter.default.addObserver(
                forName: UITextField.textDidChangeNotification,
                object: textField,
                queue: OperationQueue.main)
            { _ in
                guard let inputText = textField.text else { return }
                let textIsNotEmpty = !inputText.isEmpty
                
                createAction.isEnabled = textIsNotEmpty
            }
        }
        
        alert.addAction(createAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    @objc private func editButtonPressed(_ sender: UIBarButtonItem) {
        if !conversationListTableView.isEditing {
            sender.title = "Done"
            conversationListTableView.setEditing(true, animated: true)
        } else {
            sender.title = "Edit"
            conversationListTableView.setEditing(false, animated: true)
        }
    }
}
