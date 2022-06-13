//
//  Conversation+UITableViewDataSource.swift.swift
//  Chat-App
//
//  Created by Станислав on 08.03.2022.
//

import UIKit

extension ConversationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let messages = messages else { return UITableViewCell() }
        let message = messages[indexPath.row]
        
        if message.senderID == Constants.myID {
            let outgoingCell = tableView.dequeueReusableCell(
                withIdentifier: MessageCell.identifierForOutgoingCell,
                for: indexPath
            )
            
            guard let messageCell = outgoingCell as? MessageCell else { return outgoingCell }
            let displayData = displayDataParser.getDisplayData(from: message)
            
            messageCell.configure(withDisplayData: displayData)
            
            return messageCell
        } else {
            let incomingCell = tableView.dequeueReusableCell(
                withIdentifier: MessageCell.identifierForIncomingCell,
                for: indexPath
            )
            
            guard let messageCell = incomingCell as? MessageCell else { return incomingCell }
            let displayData = displayDataParser.getDisplayData(from: message)
            
            messageCell.configure(withDisplayData: displayData)
            
            return messageCell
        }
    }
}
