//
//  IncomingMessageCell.swift
//  Chat-App
//
//  Created by Станислав on 08.03.2022.
//

import UIKit

class MessageCell: UITableViewCell {
    
    // MARK: - IB Outlets
    @IBOutlet weak var incomingMessageBackground: UIView!
    @IBOutlet weak var incomingMessageTextLabel: UILabel!
    
    // MARK: - Public Properties
    static let identifierForIncomingCell = String(describing: MessageCell.self)
}
