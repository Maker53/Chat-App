//
//  ConversationsListView.swift
//  Chat-App
//
//  Created by Станислав on 11.06.2022.
//

import UIKit

class ConversationsListView: UIView {
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 52
        tableView.register(
            UINib(nibName: String(describing: ConversationCell.self), bundle: nil),
            forCellReuseIdentifier: ConversationCell.identifier
        )
        
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(tableView)
        
        tableView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
