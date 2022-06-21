//
//  ConversationViewController.swift
//  Chat-App
//
//  Created by Станислав on 08.03.2022.
//

import UIKit

class ConversationViewController: UIViewController {
    // MARK: - Visual Components
    
    var mainView: ConversationView? {
        view as? ConversationView
    }
    
    // MARK: - Public Properties
    
    var channel: Channel!
    var messages: [Message]?
    lazy var displayDataParser = ConversationDisplayDataParser()
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "en_EN")
        dateFormatter.setLocalizedDateFormatFromTemplate("dd_MM HH_mm")
        
        return dateFormatter
    }()
    
    // MARK: - Override Methods
    
    override func loadView() {        
        view = ConversationView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView?.tableView.dataSource = self
        mainView?.delegate = self
        
        fetchMessagesFromDB()
        fetchMessages()
        hideKeyboardWhenTappedAround()
        updateTheme()
    }
}

// MARK: - Database Methods

extension ConversationViewController {
    private func fetchMessages() {
        FirebaseService.shared.getMessages(fromChannel: channel) { [weak self] messages in
            if messages.isEmpty {
                return
            }
            
            self?.messages = messages
            self?.mainView?.tableView.reloadData()
            self?.mainView?.tableView.scrollToBottom(isAnimated: false)
        }
    }
    
    private func fetchMessagesFromDB() {
        messages = CoreDataStack.shared.fetchMessages(formChannel: channel)
        mainView?.tableView.reloadData()
        mainView?.tableView.scrollToBottom()
    }
}

// MARK: - ConversationViewDelegate

extension ConversationViewController: ConversationViewDelegate {
    func sendMessage(_ content: String) {
        FirebaseService.shared.sendMessage(withContent: content, byPath: channel.identifier)
    }
}

extension ConversationViewController: ThemeServiceDelegate {
    func updateTheme() {
        let themeDesign = ThemeService().getCurrentThemeDesign()
        
        mainView?.backgroundColor = themeDesign.backgroundColor
        mainView?.backgroundView.backgroundColor = themeDesign.backgroundColor
    }
}
