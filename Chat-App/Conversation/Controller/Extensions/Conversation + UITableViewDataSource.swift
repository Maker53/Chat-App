//
//  Conversation + UITableViewDataSource.swift.swift
//  Chat-App
//
//  Created by Станислав on 08.03.2022.
//

import UIKit

extension ConversationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: MessageCell.identifierForIncomingCell,
            for: indexPath
        )
        
        guard let messageCell = cell as? MessageCell else { return cell }
        messageCell.configureWithMock()
        return messageCell
    }
}

