//
//  Theme.swift
//  Chat-App
//
//  Created by Станислав on 19.03.2022.
//

import UIKit

enum Theme: String {
    
    case classic
    case day
    case night
}

extension Theme {
    
    @Persist(key: "appTheme", defaultValue: Theme.classic.rawValue)
    private static var appTheme: String
    
    static var current: Theme {
        Theme(rawValue: appTheme) ?? .classic
    }
    
    func save() {
        Theme.appTheme = self.rawValue
    }
}

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
