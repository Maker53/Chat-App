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
    lazy var conversationCell = ConversationCell()
    
    // MARK: - Private Properties
    private let messages = Status.mock
    
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
        messages.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        section == 0 ? "Online" : "History"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages[section].message.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ConversationCell.identifier,
            for: indexPath
        )
        
        guard let conversationCell = cell as? ConversationCell else { return cell }
        
        let status = messages[indexPath.section]
        let messages = status.message
        let message = messages[indexPath.row]
        
        conversationCell.configure(with: message, and: status)
        
        return conversationCell
    }
}
