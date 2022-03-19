//
//  MessageCell.swift
//  Chat-App
//
//  Created by Станислав on 08.03.2022.
//

import UIKit

protocol MessageCellConfiguration {
    var messageText: String? { get set }    // Свойство text недоступно,
                                            // так как используется в UITableViewCell
}

class MessageCell: UITableViewCell, MessageCellConfiguration {
    
    // MARK: - IB Outlets
    @IBOutlet weak var incomingMessageBackground: UIView!
    @IBOutlet weak var sentMessageBackground: UIView!
    @IBOutlet weak var incomingMessageTextLabel: UILabel!
    @IBOutlet weak var sentMessageTextLabel: UILabel!
    
    // MARK: - Public Properties
    static let identifierForSentCell = "sentCell"
    static let identifierForIncomingCell = "incomingCell"
    var messageText: String?
    
    func configure(withIncomingMessage message: Message) {
        if message.isIncomingMessage {
            incomingMessageTextLabel?.text = message.message
        } else {
            sentMessageTextLabel.text = message.message
        }
    }
}
