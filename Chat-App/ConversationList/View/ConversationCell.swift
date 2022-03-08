//
//  ConversationCell.swift
//  Chat-App
//
//  Created by Станислав on 07.03.2022.
//

import UIKit

protocol ConversationCellConfiguration {
    var name: String? { get set }
    var message: String? { get set }
    var date: Date? { get set }
    var online: Bool { get set }
    var hasUnreadMessages: Bool { get set }
}

class ConversationCell: UITableViewCell {
    
    // MARK: - IB Outlets
    @IBOutlet weak var fullNameLabel: UILabel?
    @IBOutlet weak var messageTextLabel: UILabel?
    @IBOutlet weak var messageDateLabel: UILabel?
    
    // MARK: - Public Properties
    static let identifier = String(describing: ConversationCell.self)
    
    func configure(with user: User) {
        name = user.fullname
        online = user.isOnline
        
        guard let message = user.messages.last else {
            message = "No messages yet"
            messageTextLabel?.font = .italicSystemFont(ofSize: 13)
            return
        }
        
        self.message = message.message
        date = message.date
        hasUnreadMessages = message.hasUnreadMessages
    }
}

extension ConversationCell: ConversationCellConfiguration {
    var name: String? {
        get {
            ""
        }
        set {
            fullNameLabel?.text = newValue
        }
    }
    
    var message: String? {
        get {
            ""
        }
        set {
            messageTextLabel?.text = newValue
        }
    }
    
    var date: Date? {
        get {
            Date()
        }
        set {
            messageDateLabel?.text = newValue?.description
        }
    }
    
    var online: Bool {
        get {
            true
        }
        set {
            
        }
    }
    
    var hasUnreadMessages: Bool {
        get {
            true
        }
        set {
            
        }
    }
}
