//
//  ThemesViewController+ThemesPickerDelegate.swift
//  Chat-App
//
//  Created by Станислав on 19.03.2022.
//

import UIKit

extension ThemesViewController: ThemesPickerDelegate {
    
    func setTheme(forChooseButton tag: Int) {
        switch tag {
        case 1: view.backgroundColor = .systemGray
        case 2: view.backgroundColor = .systemTeal
        default: view.backgroundColor = .systemBackground
        }
    }
}

