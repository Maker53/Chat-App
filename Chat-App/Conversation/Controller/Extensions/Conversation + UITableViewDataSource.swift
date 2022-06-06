//
//  Conversation + UITableViewDataSource.swift.swift
//  Chat-App
//
//  Created by Станислав on 08.03.2022.
//

import UIKit

extension ConversationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        
        if message.senderID == Constants.myID {
            let sentCell = tableView.dequeueReusableCell(
                withIdentifier: MessageCell.identifierForSentCell,
                for: indexPath
            )
            
            guard let messageCell = sentCell as? MessageCell else { return sentCell }
            
            messageCell.configure(withMessage: message)
            
            return messageCell
        } else {
            let incomingCell = tableView.dequeueReusableCell(
                withIdentifier: MessageCell.identifierForIncomingCell,
                for: indexPath
            )
            
            guard let messageCell = incomingCell as? MessageCell else { return incomingCell }
            
            messageCell.configure(withMessage: message)
            
            return messageCell
        }
    }
}
