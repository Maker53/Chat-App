//
//  Conversation + UITableViewDataSource.swift.swift
//  Chat-App
//
//  Created by Станислав on 08.03.2022.
//

import UIKit

extension ConversationViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sentCell = tableView.dequeueReusableCell(
            withIdentifier: MessageCell.identifierForSentCell,
            for: indexPath
        )
        
        let incomingCell = tableView.dequeueReusableCell(
            withIdentifier: MessageCell.identifierForIncomingCell,
            for: indexPath
        )
        
        if indexPath.section == 0 {
            guard let messageCell = incomingCell as? MessageCell else { return incomingCell }
            messageCell.configureWithMock(withIncomingMessage: incomingTextMessage)
            return messageCell
        } else {
            guard let messageCell = sentCell as? MessageCell else { return sentCell }
            messageCell.configureWithMock(withIncomingMessage: incomingTextMessage)
            return messageCell
        }
    }
}

