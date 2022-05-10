//
//  ThemeChanger.swift
//  Chat-App
//
//  Created by Станислав on 19.03.2022.
//

import UIKit

@propertyWrapper
struct Persist<T> {
    let key: String
    let defaultValue: T
    
    var wrappedValue: T {
        get { UserDefaults.standard.object(forKey: key) as? T ?? defaultValue }
        set { UserDefaults.standard.set(newValue, forKey: key) }
    }
    
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
}

enum Theme: Int {
    case classic = 0
    case day
    case night
}


extension Theme {
    @Persist(key: "appTheme", defaultValue: Theme.classic.rawValue)
    private static var appTheme: Int
    
    static var current: Theme {
        Theme(rawValue: appTheme) ?? .classic
    }
    
    func save() {
        Theme.appTheme = self.rawValue
    }
}
