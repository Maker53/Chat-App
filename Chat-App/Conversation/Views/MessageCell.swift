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
    
    func configureWithMock(withIncomingMessage message: String?) {
        sentMessageTextLabel?.text = "Some sent message"
        guard let message = message, !message.isEmpty else {
            incomingMessageTextLabel?.text = "User joined to chat"
            return
        }
        incomingMessageTextLabel?.text = message
    }
}
