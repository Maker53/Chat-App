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
    var userProfileInfo: UserProfileInfo!
    lazy var reference = db.collection("channels")
    
    // MARK: - Private Methods
    private lazy var db = Firestore.firestore()
    private let message: [String: Any] = [
        "content": "Stas test",
        "created": Timestamp(date: Date()),
        "senderID": 1,
        "senderName": "Stas Shalgin111"
    ]
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConversationListTableView()
        //TODO: Установить тему 
        
        conversationListTableView.register(
            UINib(nibName: String(describing: ConversationCell.self), bundle: nil),
            forCellReuseIdentifier: ConversationCell.identifier
        )
        
        // Network service
        reference.addSnapshotListener { [unowned self] snapshot, error in
            guard error == nil else {
                // TODO: add alert?
                print(error?.localizedDescription)
                return
            }
            
            channels = []
            
            snapshot?.documents.forEach {
                let channel: Channel
                let identifier = $0.documentID
                guard let name = $0.data()["name"] as? String else { return }
                guard let lastActivity = $0.data()["lastActivity"] as? Timestamp else { return }
                
                if let lastMessage = $0.data()["lastMessage"] as? String {
                    channel = Channel(identifier: identifier, name: name, lastMessages: lastMessage, lastActivity: lastActivity.dateValue())
                } else {
                    channel = Channel(identifier: identifier, name: name, lastMessages: nil, lastActivity: lastActivity.dateValue())
                }
                
                channels.append(channel)
            }
            
            channels.sort { channel1, channel2 in
                guard let date1 = channel1.lastActivity,
                      let date2 = channel2.lastActivity
                else {
                    return false
                }
                
                return date1 > date2
            }
            conversationListTableView.reloadData()
        }
    }
}
