//
//  AppDelegate.swift
//  Chat-App
//
//  Created by Станислав on 19.02.2022.
//

import UIKit

private enum State: String {
    case notRunning = "Not Running"
    case inactive = "Inactive"
    case active = "Active"
    case background = "Background"
    case suspended = "Suspended"
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print(
            """
            Application moved from \(State.notRunning.rawValue) state to \(State.inactive.rawValue) state:
            function - \(#function)
            """
        )
        
        return true
    }
}
