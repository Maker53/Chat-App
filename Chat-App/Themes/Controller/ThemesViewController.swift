//
//  ThemesViewController.swift
//  Chat-App
//
//  Created by Станислав on 13.03.2022.
//

import UIKit

class ThemesViewController: UIViewController {
    
    // MARK: - Public Properties
    lazy var classicThemeButton = UIButton()
    lazy var dayThemeButton = UIButton()
    lazy var nightThemeButton = UIButton()
    weak var delegate: ThemesPickerDelegate?
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupThemeViewController()
        
        delegate = ThemeChanger.shared.self
        
//        if let buttonTag = UserDefaults.standard.value(forKey: "currentTheme") as? Int {
//            switch buttonTag {
//            case 0:
//                delegate?.setTheme(from: self, and: classicThemeButton)
//                conversationListViewController?.buttonAction(self, classicThemeButton)
//            case 1:
//                delegate?.setTheme(from: self, and: dayThemeButton)
//                conversationListViewController?.buttonAction(self, dayThemeButton)
//            default:
//                delegate?.setTheme(from: self, and: nightThemeButton)
//                conversationListViewController?.buttonAction(self, nightThemeButton)
//            }
//        }
    }
    
    @objc func changeThemeButtonPressed(_ sender: Any) {
        classicThemeButton.setSelectedState(isSelected: false)
        dayThemeButton.setSelectedState(isSelected: false)
        nightThemeButton.setSelectedState(isSelected: false)

        var buttonTag = 0
        
        if let tapGestureRecognizer = sender as? UITapGestureRecognizer {
            guard let label = tapGestureRecognizer.view as? UILabel else { return }
            
            switch label.text {
            case "Day":
                buttonTag = dayThemeButton.tag
                dayThemeButton.setSelectedState(isSelected: true)
            case "Night":
                buttonTag = nightThemeButton.tag
                nightThemeButton.setSelectedState(isSelected: true)
            default:
                buttonTag = classicThemeButton.tag
                classicThemeButton.setSelectedState(isSelected: true)
            }
        } else {
            guard let themeButton = sender as? UIButton else { return }
            buttonTag = themeButton.tag
            themeButton.setSelectedState(isSelected: true)
        }

        delegate?.setTheme(forChooseButton: buttonTag, in: self)
    }
    
    @objc func cancelBarButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Extension for UIButton
extension UIButton {
    
    func setSelectedState(isSelected: Bool) {
        layer.borderWidth = isSelected ? 3 : 1
        layer.borderColor = isSelected
            ? CGColor(red: 4/255, green: 51/255, blue: 255/255, alpha: 1)
            : CGColor(red: 255, green: 255, blue: 255, alpha: 0.75)
    }
}
