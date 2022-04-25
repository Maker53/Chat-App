//
//  ThemeChanger.swift
//  Chat-App
//
//  Created by Станислав on 19.03.2022.
//

import UIKit

protocol ThemesPickerDelegate: AnyObject {
    
    func setTheme(forChooseButton tag: Int, in themesViewController: ThemesViewController)
}

class ThemeChanger {
    
    static let shared = ThemeChanger()
    
    private init() {}
    
    /*
     Здесь функция changeTheme создается в классе ThemeChanger, соответственно ThemeChanger
     держит сильную ссылку на changeTheme. В блоке замыкания мы, через self обращаемся к
     нашему классу ThemeChanger и следовательно держим ссылку на класс уже changeTheme.
     Для избежания retain cycle делаем слабую ссылку в листе захвата на self.
     */
    func changeTheme(with themesViewController: ThemesViewController) {
        themesViewController.updateThemeAction = { [weak self] viewController, buttonTag in
            self!.setTheme(from: buttonTag, and: viewController)
        }
    }
    
    private func setTheme(from buttonTag: Int, and viewController: ThemesViewController) {
        switch buttonTag {
        case 1: viewController.view.backgroundColor = .systemGray
        case 2: viewController.view.backgroundColor = .systemTeal
        default: viewController.view.backgroundColor = .systemBackground
        }
    }
}

extension ThemeChanger: ThemesPickerDelegate {
    
    func setTheme(forChooseButton tag: Int, in themesViewController: ThemesViewController) {
        setTheme(from: tag, and: themesViewController)
    }
}
