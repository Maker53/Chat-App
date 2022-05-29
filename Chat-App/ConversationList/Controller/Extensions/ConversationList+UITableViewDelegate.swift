//
//  ConversationList+UITableViewDelegate.swift
//  Chat-App
//
//  Created by Станислав on 09.03.2022.
//

import UIKit
import FirebaseFirestore

extension ConversationListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let conversationVC = ConversationViewController()
        let channelID = channels[indexPath.row].identifier
        let messagesReference = reference.document(channelID).collection("messages")
        var messages: [Message] = []
        
        messagesReference.addSnapshotListener { snapshot, error in
            guard error == nil else {
                // TODO: add alert?
                print(error?.localizedDescription)
                return
            }
            
            snapshot?.documents.forEach {
                let message: Message
                
                let senderID = $0.documentID
                guard let senderName = $0.data()["senderName"] as? String else { return }
                guard let content = $0.data()["content"] as? String else { return }
                guard let created = $0.data()["created"] as? Timestamp else { return }
                
                message = Message(content: content, created: created.dateValue(), senderID: senderID, senderName: senderName)
                messages.append(message)
            }
            
            conversationVC.messages = messages
            conversationVC.messagesListTableView.reloadData()
        }
        
        navigationController?.pushViewController(conversationVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let channelID = channels[indexPath.row].identifier
            reference.document(channelID).delete()
        }
    }
}
