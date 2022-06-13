//
//  ThemesService.swift
//  Chat-App
//
//  Created by Станислав on 12.06.2022.
//

protocol ThemeServiceDelegate: AnyObject {    
    func updateTheme()
}

class ThemeService {    
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
