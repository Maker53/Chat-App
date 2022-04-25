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
    
    /*
     delegate должен быть со слабой ссылкой, так как при инициализации delegate
     мы создаем объект ThemesPickerDelegate, через который в дальнейшем будем
     обращаться к методу протокола, реализованном в класса ThemesPicker,
     соответственно создается ссылка на ThemesPicker (сделали ее слабой).
     При обращении к методу протокола через delegate мы передаем в параметр функции
     наш ThemesViewController, инициализируя self'ом, следовательно в ThemesPicker
     появляется сильная ссылка на наш ThemesViewController и если бы мы не проставили
     слабую ссылку delegate, то случился бы retain cycle
     */
    weak var delegate: ThemesPickerDelegate?
    var updateThemeAction: ((ThemesViewController, Int) -> Void)?
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupThemeViewController()
        delegate = ThemeChanger.shared.self
        setCurrentThemeFromUserDefault()
    }
    
    // MARK: - Buttons Actions
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
        
        UserDefaults.standard.set(buttonTag, forKey: "currentTheme")

//        delegate?.setTheme(forChooseButton: buttonTag, in: self)
        ThemeChanger.shared.changeTheme(with: self)
        updateThemeAction?(self, buttonTag)
    }
    
    @objc func cancelBarButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private Methods
    private func setCurrentThemeFromUserDefault() {
        if let buttonTag = UserDefaults.standard.value(forKey: "currentTheme") as? Int {
            switch buttonTag {
            case 1: dayThemeButton.setSelectedState(isSelected: true)
            case 2: nightThemeButton.setSelectedState(isSelected: true)
            default: classicThemeButton.setSelectedState(isSelected: true)
            }
            
//            delegate?.setTheme(forChooseButton: buttonTag, in: self)
            ThemeChanger.shared.changeTheme(with: self)
            updateThemeAction?(self, buttonTag)
        }
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
