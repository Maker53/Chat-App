//
//  ThemesViewController.swift
//  Chat-App
//
//  Created by Станислав on 13.03.2022.
//

import UIKit

class ThemesViewController: UIViewController {
    
    // MARK: - Public Properties
    // Тут мог бы быть retain cycle, так как обращение к этим свойствам идет и
    // в ConversationListViewController (в протоколе и замыкании). Однако, мы сделали
    // связь между ConversationListViewController и ThemesViewController weak (в делегает и свойстве
    // conversationListViewController), поэтому круг между двумя контроллерами и свойствами
    // не замкнется
    lazy var classicThemeButton = UIButton()
    lazy var dayThemeButton = UIButton()
    lazy var nightThemeButton = UIButton()
    
    // ThemesViewController держит ссылку на ConversationListViewController в роли делегата,
    // а ConversationListViewController, в свою очередь, ссылается на ThemesViewController
    // (создается экземпляр класса ThemesViewController при переходе по кнопке settings
    // Для того, чтобы избежать retain cycle делаем делегат слабым
    // То же самое происходит и со свойством conversationListViewController
    weak var delegate: ThemesPickerDelegate?
    weak var conversationListViewController: ConversationListViewController?
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupThemeViewController()
        
        if let buttonTag = UserDefaults.standard.value(forKey: "currentTheme") as? Int {
            switch buttonTag {
            case 0:
                delegate?.setTheme(from: self, and: classicThemeButton)
                conversationListViewController?.buttonAction(self, classicThemeButton)
            case 1:
                delegate?.setTheme(from: self, and: dayThemeButton)
                conversationListViewController?.buttonAction(self, dayThemeButton)
            default:
                delegate?.setTheme(from: self, and: nightThemeButton)
                conversationListViewController?.buttonAction(self, nightThemeButton)
            }
        }
    }
}
