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
    
    // MARK: - Public Properties
    let users = User.mock
    let displayData = ConversationListDisplayDataParser()
    let buttonAction: ((ThemesViewController, UIButton) -> Void) = { viewController , button in
        viewController.classicThemeButton.setSelectedState(isSelected: false)
        viewController.dayThemeButton.setSelectedState(isSelected: false)
        viewController.nightThemeButton.setSelectedState(isSelected: false)
        
        UserDefaults.standard.set(button.tag, forKey: "currentTheme")
        button.setSelectedState(isSelected: true)
        
        switch button.tag {
        case 0:
            viewController.view.backgroundColor = .systemBackground
        case 1:
            viewController.view.backgroundColor = .systemTeal
        default:
            viewController.view.backgroundColor = .systemGray
        }
    }
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConversationListTableView()
        
        conversationListTableView.register(
            UINib(nibName: String(describing: ConversationCell.self), bundle: nil),
            forCellReuseIdentifier: ConversationCell.identifier
        )
        
        conversationListTableView.dataSource = self
        conversationListTableView.delegate = self
    }
}
