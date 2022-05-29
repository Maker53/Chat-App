//
//  ConversationList+UITableViewDelegate.swift
//  Chat-App
//
//  Created by Станислав on 09.03.2022.
//

import UIKit

extension ConversationListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let conversationVC = ConversationViewController()
        
        navigationController?.pushViewController(conversationVC, animated: true)
    }
}
