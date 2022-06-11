//
//  ConversationListViewController.swift
//  Chat-App
//
//  Created by Станислав on 07.03.2022.
//

import UIKit
import FirebaseFirestore

class ConversationListViewController: UIViewController {
    // MARK: - UI
    lazy var conversationListTableView = UITableView(frame: .zero, style: .insetGrouped)
    
    // MARK: - Public Properties
    let displayData = ConversationListDisplayDataParser()
    var channels: [Channel] = []
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConversationListTableView()
        //TODO: Установить тему
        
        conversationListTableView.register(
            UINib(nibName: String(describing: ConversationCell.self), bundle: nil),
            forCellReuseIdentifier: ConversationCell.identifier
        )
        
        FirebaseService.shared.getChannels { [unowned self] channels in
            self.channels = channels
            self.conversationListTableView.reloadData()
        }
        
//        DataStoreManager.shared.save { context in
//            DBChannel(context: context)
//        }
    }
}
