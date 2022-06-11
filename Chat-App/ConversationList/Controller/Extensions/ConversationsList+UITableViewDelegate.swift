//
//  ConversationsList+UITableViewDelegate.swift
//  Chat-App
//
//  Created by Станислав on 09.03.2022.
//

import UIKit
import FirebaseFirestore

extension ConversationsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let conversationVC = ConversationViewController()
        conversationVC.channelID = channels[indexPath.row].identifier
        
        navigationController?.pushViewController(conversationVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let path = channels[indexPath.row].identifier
            
            FirebaseService.shared.deleteChannel(byPath: path)
        }
    }
}
