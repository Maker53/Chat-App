//
//  MessageCell.swift
//  Chat-App
//
//  Created by Станислав on 08.03.2022.
//

import UIKit

class MessageCell: UITableViewCell {
    // MARK: - IB Outlets
    @IBOutlet weak var incomingMessageBackground: UIView!
    @IBOutlet weak var sentMessageBackground: UIView!
    @IBOutlet weak var incomingNameLabel: UILabel!
    @IBOutlet weak var incomingMessageTextLabel: UILabel!
    @IBOutlet weak var sentMessageTextLabel: UILabel!
    @IBOutlet weak var timeSentMessage: UILabel!
    @IBOutlet weak var incomingTimeMesage: UILabel!
    
    // MARK: - Public Properties
    static let identifierForSentCell = "sentCell"
    static let identifierForIncomingCell = "incomingCell"
    
    func configure(withDisplayData data: DisplayConversationData) {
        if data.senderID == Constants.myID {
            sentMessageTextLabel.text = data.message
            timeSentMessage.text = data.date
        } else {
            incomingMessageTextLabel.text = data.message
            incomingNameLabel.text = data.name
            incomingTimeMesage.text = data.date
        }
    }
}
