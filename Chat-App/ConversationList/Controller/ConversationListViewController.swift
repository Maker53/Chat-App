//
//  ConversationListViewController.swift
//  Chat-App
//
//  Created by Станислав on 07.03.2022.
//

import UIKit

class ConversationListViewController: UIViewController {
    
    // MARK: - UI
    lazy var conversationListTableView = UITableView(frame: .zero, style: .insetGrouped)
    
    // MARK: - Private Properties
    private let users = User.mock
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConversationListTableView()
        
        conversationListTableView.register(
            UINib(nibName: String(describing: ConversationCell.self), bundle: nil),
            forCellReuseIdentifier: ConversationCell.identifier
        )
        
        conversationListTableView.dataSource = self
    }
}

extension ConversationListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        section == 0 ? "Online" : "History"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let onlineUsersCount = users.filter { $0.isOnline }
        let offlineUsersCount = users.filter { !$0.isOnline }
        
        guard section == 0 else { return offlineUsersCount.count }
        return onlineUsersCount.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ConversationCell.identifier,
            for: indexPath
        )
        
        guard let conversationCell = cell as? ConversationCell else { return cell }
        
        if indexPath.section == 0 {
            let user = users.filter { $0.isOnline }[indexPath.row]
            conversationCell.configure(with: user)
        } else {
            let user = users.filter { !$0.isOnline }[indexPath.row]
            conversationCell.configure(with: user)
        }
        
        return conversationCell
    }
}
