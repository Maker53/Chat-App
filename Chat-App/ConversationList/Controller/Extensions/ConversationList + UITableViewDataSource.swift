//
//  ConversationList + UITableViewDataSource.swift
//  Chat-App
//
//  Created by Станислав on 08.03.2022.
//

import UIKit

extension ConversationListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        section == 0 ? "Online" : "History"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let onlineUsersCount = users.filter { $0.isOnline }
        let offlineUsersCount = users.filter { !$0.isOnline }
        
        guard section == 0 else { return offlineUsersCount.count }
        return onlineUsersCount.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ConversationCell.identifier,
            for: indexPath
        )
        
        guard let conversationCell = cell as? ConversationCell else { return cell }
        
        if indexPath.section == 0 {
            let user = users.filter { $0.isOnline }[indexPath.row]
            conversationCell.configure(with: user)
        } else {
            let user = users.filter { !$0.isOnline }[indexPath.row]
            conversationCell.configure(with: user)
        }
        
        return conversationCell
    }
}

extension ConversationListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let conversationVC = ConversationViewController()
        var user: User
        
        if indexPath.section == 0 {
            user = users.filter { $0.isOnline }[indexPath.row]
        } else {
            user = users.filter { !$0.isOnline }[indexPath.row]
        }
    
        conversationVC.title = user.fullname
        conversationVC.incomingTextMessage = user.messages?.last?.message
        
        
        navigationController?.pushViewController(conversationVC, animated: true)
    }
}
