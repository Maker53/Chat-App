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
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var fullNameLabel: UILabel?
    @IBOutlet weak var messageTextLabel: UILabel?
    @IBOutlet weak var messageDateLabel: UILabel?
    
    // MARK: - Public Properties
    static let identifier = String(describing: ConversationCell.self)
    
    // MARK: - Private Properties
    private let dateFormatter: DateFormatter = {
       let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "en_RU")
        
        return dateFormatter
    }()
    
    func configure(with user: User) {
        name = user.fullname
        online = user.isOnline
        
        guard let notEmptyMessage = user.messages?.last, !notEmptyMessage.message.isEmpty else {
            message = nil
            date = nil
            hasUnreadMessages = false
            
            return
        }
        
        message = notEmptyMessage.message
        date = notEmptyMessage.date
        hasUnreadMessages = notEmptyMessage.hasUnreadMessages
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
            guard let message = newValue else {
                messageTextLabel?.text = "No messages yet"
                messageTextLabel?.font = .italicSystemFont(ofSize: 13)
                return
            }
            messageTextLabel?.text = message
        }
    }
    
    var date: Date? {
        get {
            Date()
        }
        set {
            guard let date = newValue else {
                messageDateLabel?.text = ""
                return
            }
            
            let startOfDay = Calendar.current.startOfDay(for: Date())
            
            // Сhecking whether the message arrived today or in previous days
            
            if 0..<86400 ~= startOfDay.distance(to: date) {
                dateFormatter.setLocalizedDateFormatFromTemplate("HH:mm")
            } else {
                dateFormatter.setLocalizedDateFormatFromTemplate("dd MMM")
            }
            
            messageDateLabel?.text = dateFormatter.string(from: date)
        }
    }
    
    var online: Bool {
        get {
            true
        }
        set {
            if newValue {
                view.backgroundColor = #colorLiteral(red: 1, green: 0.986296446, blue: 0.7520558787, alpha: 1)
            } else {
                view.backgroundColor = .systemBackground
            }
        }
    }
    
    var hasUnreadMessages: Bool {
        get {
            true
        }
        set {
            if newValue {
                messageTextLabel?.font = .systemFont(ofSize: 13, weight: .black)
            }
        }
    }
}
