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
    
    lazy var displayDataParser = ConversationDisplayDataParser()
    var channelID: String!
    var messages: [Message]?
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "en_RU")
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
        
        hideKeyboardWhenTappedAround()
        updateTheme()
        
        FirebaseService.shared.getMessages(byPath: channelID) { [weak self] messages in
            guard let self = self else { return }
            self.messages = messages
            self.mainView?.tableView.reloadData()
        }
    }
}

// TODO Убрать этот метод и в ConversationView создать протокол и здесь его реализовать
extension ConversationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
//        sendMessage()
        textField.text = ""
        
        return true
    }
}

extension ConversationViewController: ThemeServiceDelegate {
    func updateTheme() {
        let themeDesign = ThemeService().getCurrentThemeDesign()
        
        mainView?.backgroundColor = themeDesign.backgroundColor
        mainView?.backgroundView.backgroundColor = themeDesign.backgroundColor
    }
}
