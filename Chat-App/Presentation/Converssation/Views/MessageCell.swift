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
    @IBOutlet weak var outgoingMessageBackground: UIView!
    @IBOutlet weak var incomingNameLabel: UILabel!
    @IBOutlet weak var incomingMessageTextLabel: UILabel!
    @IBOutlet weak var outgoingMessageTextLabel: UILabel!
    @IBOutlet weak var outgoingTimeMessage: UILabel!
    @IBOutlet weak var incomingTimeMesage: UILabel!
    
    // MARK: - Public Properties
    
    static let identifierForOutgoingCell = "outgoingCell"
    static let identifierForIncomingCell = "incomingCell"
    
    // MARK: - Public Methods
    
    func configure(withDisplayData data: ConversationDisplayData, andThemeDesign themeDesign: ThemesDesign) {
        if data.senderID == Constants.myID {
            outgoingMessageTextLabel.text = data.message
            outgoingTimeMessage.text = data.date
        } else {
            incomingMessageTextLabel.text = data.message
            incomingNameLabel.text = data.name
            incomingTimeMesage.text = data.date
        }
        
        updateTheme(themeDesign)
    }
    
    // MARK: - Private Methods
    
    private func updateTheme(_ themeDesign: ThemesDesign) {
        if incomingMessageBackground != nil {
            incomingMessageBackground.backgroundColor = themeDesign.incomingMessageColor
        } else if outgoingMessageBackground != nil {
            outgoingMessageBackground.backgroundColor = themeDesign.outgoingMessageColor
        }
    }
}
