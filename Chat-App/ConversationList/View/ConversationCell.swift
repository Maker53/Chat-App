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

class ConversationCell: UITableViewCell, ConversationCellConfiguration {
    
    // MARK: - IB Outlets
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var fullNameLabel: UILabel?
    @IBOutlet weak var messageTextLabel: UILabel?
    @IBOutlet weak var messageDateLabel: UILabel?
    
    // MARK: - Public Properties
    var name: String?
    var message: String?
    var date: Date?
    var online: Bool = false
    var hasUnreadMessages: Bool = false
    static let identifier = String(describing: ConversationCell.self)
    
    // MARK: - Private Properties
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "en_RU")
        
        return dateFormatter
    }()
    
    // MARK: - Public Methods
    func configure(with user: User) {
        name = user.fullname
        online = user.isOnline
        message = user.messages?.last?.message
        date = user.messages?.last?.date
        hasUnreadMessages = user.messages?.last?.hasUnreadMessages ?? false
        
        setupDataToCell()
    }
    
    // MARK: - Private Methods
    private func setupDataToCell() {
        if let name = name {
            fullNameLabel?.text = name
        }
        
        if let message = message, !message.isEmpty {
            messageTextLabel?.text = message
        } else {
            date = nil
            hasUnreadMessages = false
            messageTextLabel?.text = "No messages yet"
            messageTextLabel?.font = .italicSystemFont(ofSize: 13)
        }
        
        if let date = date {
            let startOfDay = Calendar.current.startOfDay(for: Date())
            
            // Сhecking whether the message arrived today or in previous days
            if 0..<86400 ~= startOfDay.distance(to: date) {
                dateFormatter.setLocalizedDateFormatFromTemplate("HH:mm")
            } else {
                dateFormatter.setLocalizedDateFormatFromTemplate("dd MMM")
            }
            
            messageDateLabel?.text = dateFormatter.string(from: date)
            
        } else {
            messageDateLabel?.text = ""
        }
        
        if online {
            view.backgroundColor = #colorLiteral(red: 1, green: 0.986296446, blue: 0.7520558787, alpha: 1)
        } else {
            view.backgroundColor = .systemBackground
        }
        
        if hasUnreadMessages {
            messageTextLabel?.font = .systemFont(ofSize: 13, weight: .black)
        }
    }
}
