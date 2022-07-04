//
//  ConversationsListTableViewDelegate.swift
//  Chat-App
//
//  Created by Станислав on 02.07.2022.
//

import UIKit
import CoreData

protocol ConversationsListTableViewNavigation: AnyObject {
    
    func pushViewController(_ controller: UIViewController)
}

class ConversationsListTableViewDelegate: NSObject, UITableViewDelegate {
    
    // MARK: - Delegate
    
    weak var delegate: ConversationsListTableViewNavigation!
    
    // MARK: - Private Properties
    
    private let fetchController: NSFetchedResultsController<ChannelDB>?
    
    // MARK: - Initializer
    
    init(fetchController: NSFetchedResultsController<ChannelDB>?) {
        self.fetchController = fetchController
    }
    
    // MARK: - Delegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let channelDB = fetchController?.object(at: indexPath) else { return }
        guard let channel = Channel(dbModel: channelDB) else { return }
        let conversationVC = ConversationViewController(channel: channel)
        
        conversationVC.channel = channel
        conversationVC.title = channel.name
        
        delegate.pushViewController(conversationVC)
    }
}
