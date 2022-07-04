//
//  ConversationTableViewDataSource.swift
//  Chat-App
//
//  Created by Станислав on 04.07.2022.
//

import UIKit
import CoreData

class ConversationTableViewDataSource: NSObject, UITableViewDataSource {
    
    // MARK: - Public Properties
    
    let fetchController: NSFetchedResultsController<MessageDB>?
    
    // MARK: - Private Properties
    
    private let displayDataService: ConversationDisplayDataService!
    private let themeDesign: ThemesDesign!
    
    // MARK: - Initializer
    
    init(fetchController: NSFetchedResultsController<MessageDB>?, themeDesign: ThemesDesign) {
        self.fetchController = fetchController
        self.displayDataService = ServiceAssembly.conversationDisplayDataService
        self.themeDesign = themeDesign
    }
    
    // MARK: - Data Source Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fetchController?.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let messageDB = fetchController?.object(at: indexPath) else { return UITableViewCell() }
        guard let message = Message(dbModel: messageDB) else { return UITableViewCell() }
        
        if message.senderID == Constants.myID {
            let outgoingCell = tableView.dequeueReusableCell(
                withIdentifier: MessageCell.identifierForOutgoingCell,
                for: indexPath
            )
            
            guard let messageCell = outgoingCell as? MessageCell else { return outgoingCell }
            let displayData = displayDataService.getDisplayData(from: message)
            
            messageCell.configure(withDisplayData: displayData, andThemeDesign: themeDesign)
            
            return messageCell
        } else {
            let incomingCell = tableView.dequeueReusableCell(
                withIdentifier: MessageCell.identifierForIncomingCell,
                for: indexPath
            )
            
            guard let messageCell = incomingCell as? MessageCell else { return incomingCell }
            let displayData = displayDataService.getDisplayData(from: message)
            
            messageCell.configure(withDisplayData: displayData, andThemeDesign: themeDesign)
            
            return messageCell
        }
    }
}
