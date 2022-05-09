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
    @IBOutlet weak var fullNameLabel: UILabel?
    @IBOutlet weak var messageTextLabel: UILabel?
    @IBOutlet weak var messageDateLabel: UILabel?
    
    // MARK: - Public Properties
    static let identifier = String(describing: ConversationCell.self)
    
    // MARK: - Public Methods
    func configure(with displayData: DisplayData) {
        fullNameLabel?.text = displayData.name
        messageTextLabel?.text = displayData.message
        
        if displayData.message == "No messages yet" {
            messageTextLabel?.font = .italicSystemFont(ofSize: 13)
        }
        
        messageDateLabel?.text = displayData.date
        
        if displayData.online {
            view.backgroundColor = #colorLiteral(red: 1, green: 0.986296446, blue: 0.7520558787, alpha: 1)
        } else {
            view.backgroundColor = .systemBackground
        }
        
        if displayData.hasUnreadMessages {
            messageTextLabel?.font = .systemFont(ofSize: 13, weight: .black)
        }
    }
}
