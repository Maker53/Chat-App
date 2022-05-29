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
        
        navigationItem.rightBarButtonItems = [setupNewChannelBarButton(), setupProfileBarButton()]
        navigationItem.leftBarButtonItem = setupSettingsBarButton()
        
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
    
    private func setupNewChannelBarButton() -> UIBarButtonItem {
        let barButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(newChannelButtonPressed))
        
        barButton.tintColor = .systemGray
        
        return barButton
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
        alert.addTextField()
        alert.textFields?[0].placeholder = "Channel name"
        
        let createAction = UIAlertAction(title: "Create", style: .default) { _ in
            // TODO: Add network service
            if let channelName = alert.textFields?[0].text, !channelName.isEmpty {
                self.reference.addDocument(data: ["name": channelName, "lastActivity": Timestamp(date: Date())])
            } else {
                self.reference.addDocument(data: ["name": "Empty", "lastActivity": Timestamp(date: Date())])
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(createAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}
