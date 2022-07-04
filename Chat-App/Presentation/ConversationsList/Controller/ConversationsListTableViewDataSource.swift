//
//  ConversationsListTableViewDataSource.swift
//  Chat-App
//
//  Created by Станислав on 02.07.2022.
//

import UIKit
import CoreData

class ConversationsListTableViewDataSource: NSObject, UITableViewDataSource {
    
    // MARK: - Public Properties
    
    let fetchController: NSFetchedResultsController<ChannelDB>?
    
    // MARK: - Private Properties
    
    private let displayDataService: ConversationsListDisplayDataService!
    private let firebaseService: ChannelFirebaseService!
    
    // MARK: - Initializer
    
    init(fetchController: NSFetchedResultsController<ChannelDB>?, firebaseService: ChannelFirebaseService) {
        self.fetchController = fetchController
        self.displayDataService = ServiceAssembly.conversationsListDisplayDataService
        self.firebaseService = firebaseService
    }
    
    // MARK: - Data Source Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fetchController?.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ConversationCell.identifier,
            for: indexPath)
        
        guard let conversationCell = cell as? ConversationCell else { return cell }
        guard let channel = fetchChannel(by: indexPath) else { return cell }
        let displayData = displayDataService.getDisplayData(from: channel)
        
        conversationCell.configure(with: displayData)
        
        return conversationCell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let channelDB = fetchController?.object(at: indexPath) else { return }
            guard let channel = Channel(dbModel: channelDB) else { return }
            
            firebaseService.deleteChannel(channel)
        }
    }
    
    // MARK: - Private Method
    
    private func fetchChannel(by indexPath: IndexPath) -> Channel? {
        guard let channelDB = fetchController?.object(at: indexPath) else { return nil }
        let channel = Channel(dbModel: channelDB)
                
        return channel
    }
}
