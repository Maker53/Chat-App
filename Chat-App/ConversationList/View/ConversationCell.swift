//
//  ConversationCell.swift
//  Chat-App
//
//  Created by Станислав on 07.03.2022.
//

import UIKit

class ConversationCell: UITableViewCell {
    // MARK: - IB Outlets
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var conversationNameLabel: UILabel?
    @IBOutlet weak var messageTextLabel: UILabel?
    @IBOutlet weak var messageDateLabel: UILabel?
    
    // MARK: - Public Properties
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
