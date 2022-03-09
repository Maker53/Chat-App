//
//  ConversationList+UITableViewDelegate.swift
//  Chat-App
//
//  Created by Станислав on 09.03.2022.
//

import UIKit

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
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
