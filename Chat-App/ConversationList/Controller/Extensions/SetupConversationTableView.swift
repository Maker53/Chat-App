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
        
        navigationItem.rightBarButtonItem = setupCustomBarButtonItem()
        
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
    
    // MARK: - Setup Custom BarButtonItem
    private func setupCustomBarButtonItem() -> UIBarButtonItem {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "person.fill")
        
        button.setImage(image, for: .normal)
        button.tintColor = .systemGray
        
        button.addTarget(self, action: #selector(openProfileButtonPressed), for: .touchUpInside)
        
        let barItem = UIBarButtonItem(customView: button)
        return barItem
    }
    
    @objc private func openProfileButtonPressed() {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        let profileViewController = storyboard.instantiateViewController(withIdentifier: "ProfileVC")
        let navigationController = UINavigationController(rootViewController: profileViewController)
        present(navigationController, animated: true)
    }
}
