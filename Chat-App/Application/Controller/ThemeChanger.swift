//
//  ThemeChanger.swift
//  Chat-App
//
//  Created by Станислав on 19.03.2022.
//

import Foundation

protocol ThemesPickerDelegate: AnyObject {
    
    func setTheme(forChooseButton tag: Int, in themesViewController: ThemesViewController)
}

class ThemeChanger {
    
    static let shared = ThemeChanger()
    
    private init() {}
}

extension ThemeChanger: ThemesPickerDelegate {
    
    func setTheme(forChooseButton tag: Int, in themesViewController: ThemesViewController) {
        switch tag {
        case 1: themesViewController.view.backgroundColor = .systemGray
        case 2: themesViewController.view.backgroundColor = .systemTeal
        default: themesViewController.view.backgroundColor = .systemBackground
        }
    }
}
