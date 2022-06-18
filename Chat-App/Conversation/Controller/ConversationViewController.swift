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
    
    var channelID: String!
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
        
        fetchMessages()
        hideKeyboardWhenTappedAround()
        updateTheme()
    }
}

// MARK: - Firebase Methods

extension ConversationViewController {
    private func fetchMessages() {
        FirebaseService.shared.getMessages(byPath: channelID) { [weak self] messages in
            self?.messages = messages
            self?.mainView?.tableView.reloadData()
            self?.mainView?.tableView.scrollToBottom(isAnimated: false)
        }
    }
}

// MARK: - ConversationViewDelegate

extension ConversationViewController: ConversationViewDelegate {
    func sendMessage(_ content: String) {
        FirebaseService.shared.sendMessage(withContent: content, byPath: channelID)
    }
}

extension ConversationViewController: ThemeServiceDelegate {
    func updateTheme() {
        let themeDesign = ThemeService().getCurrentThemeDesign()
        
        mainView?.backgroundColor = themeDesign.backgroundColor
        mainView?.backgroundView.backgroundColor = themeDesign.backgroundColor
    }
}
