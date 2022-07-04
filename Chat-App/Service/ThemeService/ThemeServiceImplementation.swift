//
//  ThemeServiceImplementation.swift
//  Chat-App
//
//  Created by Станислав on 03.07.2022.
//

class ThemeServiceImplementation: ThemeService {
    
    func getCurrentThemeDesign() -> ThemesDesign {
        switch Theme.current {
        case .day: return DayTheme()
        case .night: return NightTheme()
        default: return ClassicTheme()
        }
    }
    
    func getCurrentTheme() -> Theme {
        Theme.current
    }
    
    func saveTheme(_ theme: Theme) {
        theme.save()
    }
}
