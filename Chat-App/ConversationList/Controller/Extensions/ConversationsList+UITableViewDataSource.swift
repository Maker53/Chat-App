//
//  ConversationsList+UITableViewDataSource.swift
//  Chat-App
//
//  Created by Станислав on 08.03.2022.
//

import UIKit

extension ConversationsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fetchController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ConversationCell.identifier,
            for: indexPath)
        
        guard let conversationCell = cell as? ConversationCell else { return cell }
        let channelDB = fetchController.object(at: indexPath)
        guard let channel = Channel(dbModel: channelDB) else { return cell }
        let displayData = ConversationsListDisplayDataParser().getDisplayData(from: channel)
        
        conversationCell.configure(with: displayData)
        
        return conversationCell
    }
}
