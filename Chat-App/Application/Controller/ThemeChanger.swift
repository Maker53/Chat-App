//
//  ThemeChanger.swift
//  Chat-App
//
//  Created by Станислав on 19.03.2022.
//

import Foundation

class ThemeChanger {
    
    static let shared = ThemeChanger()
    weak var delegate: ThemesPickerDelegate?
    
    private init() {}
    
    
}
