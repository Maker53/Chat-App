//
//  ConversationViewController.swift
//  Chat-App
//
//  Created by Станислав on 08.03.2022.
//

import UIKit

class ConversationViewController: UIViewController {
    
    // MARK: - UI
    lazy var messagesListTableView = UITableView(frame: .zero, style: .plain)
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConversationViewController()
        
        messagesListTableView.register(
            UINib(nibName: "SentMessageCell", bundle: nil),
            forCellReuseIdentifier: MessageCell.identifierForSentCell
        )
        
        messagesListTableView.register(
            UINib(nibName: "IncomingMessageCell", bundle: nil),
            forCellReuseIdentifier: MessageCell.identifierForSentCell
        )
        
        messagesListTableView.dataSource = self
    }
}
