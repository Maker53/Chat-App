//
//  ThemeService.swift
//  Chat-App
//
//  Created by Станислав on 03.07.2022.
//

protocol ThemeService {
    
    func getCurrentThemeDesign() -> ThemesDesign
    func getCurrentTheme() -> Theme
    func saveTheme(_ theme: Theme)
}
