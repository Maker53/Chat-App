//
//  Conversation + UITableViewDataSource.swift.swift
//  Chat-App
//
//  Created by Станислав on 08.03.2022.
//

import UIKit

extension ConversationViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        dateFormatter.string(from: messages[section].date)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if messages[indexPath.section].isIncomingMessage {
            let incomingCell = tableView.dequeueReusableCell(
                withIdentifier: MessageCell.identifierForIncomingCell,
                for: indexPath
            )
            
            guard let messageCell = incomingCell as? MessageCell else { return incomingCell }
            messageCell.configure(withIncomingMessage: messages[indexPath.section])
            
            return messageCell
        } else {
            let sentCell = tableView.dequeueReusableCell(
                withIdentifier: MessageCell.identifierForSentCell,
                for: indexPath
            )
            
            guard let messageCell = sentCell as? MessageCell else { return sentCell }
            messageCell.configure(withIncomingMessage: messages[indexPath.section])
            
            return messageCell
        }
    }
}
