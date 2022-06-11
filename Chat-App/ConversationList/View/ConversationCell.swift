//
//  ConversationCell.swift
//  Chat-App
//
//  Created by Станислав on 07.03.2022.
//

import UIKit

class ConversationCell: UITableViewCell {
    // MARK: - IB Outlets
    @IBOutlet private weak var view: UIView!
    @IBOutlet private weak var conversationNameLabel: UILabel?
    @IBOutlet private weak var messageTextLabel: UILabel?
    @IBOutlet private weak var messageDateLabel: UILabel?
    
    // MARK: - Cell Identifier
    static let identifier = String(describing: ConversationCell.self)
    
    // MARK: - Public Methods
    func configure(with displayData: DisplayData) {
        conversationNameLabel?.text = displayData.name
        messageTextLabel?.text = displayData.message
        messageDateLabel?.text = displayData.date
        
        if displayData.message == "No messages yet" {
            messageTextLabel?.font = .italicSystemFont(ofSize: 13)
        }
    }
}
