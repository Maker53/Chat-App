//
//  ButtonsActions.swift
//  Chat-App
//
//  Created by Станислав on 13.03.2022.
//

import UIKit

extension ThemesViewController {
    
    @objc func changeThemeButtonPressed(_ sender: Any) {
        var button = UIButton()
        
        if let tapGestureRecognizer = sender as? UITapGestureRecognizer {
            guard let label = tapGestureRecognizer.view as? UILabel else { return }
            
            switch label.text {
            case "Classic":
                button = classicThemeButton
            case "Day":
                button = dayThemeButton
            default:
                button = nightThemeButton
            }
        } else {
            guard let themeButton = sender as? UIButton else { return }
            button = themeButton
        }
        
        // Оба свойства - delegate и conversationListViewController со слабой ссылкой,
        // поэтому retain cycle не произойдет
//        delegate?.setTheme(from: self, and: button)
        conversationListViewController?.buttonAction(self, button)
    }
    
    @objc func cancelBarButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
}

extension UIButton {
    
    func setSelectedState(isSelected: Bool) {
        if isSelected {
            self.layer.borderWidth = 3
            self.layer.borderColor = CGColor(red: 4/255, green: 51/255, blue: 255/255, alpha: 1)
        } else {
            self.layer.borderWidth = 1
            self.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 0.75)
        }
    }
}
