//
//  AppDelegate.swift
//  Chat-App
//
//  Created by Станислав on 19.02.2022.
//

import UIKit

// MARK: - States
private enum State: String {
    case notRunning = "Not Running"
    case inactive = "Inactive"
    case active = "Active"
    case background = "Background"
    case suspended = "Suspended"
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Public Properties
    var window: UIWindow?

    // MARK: - Lifecycle Methods
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        printLog(appGoesStateFrom: .notRunning, to: .inactive)
        
        return true
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        printLog(appGoesStateFrom: .inactive, to: .inactive)
        
        return true
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        printLog(appGoesStateFrom: .background, to: .inactive)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        printLog(appGoesStateFrom: .inactive, to: .active)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        printLog(appGoesStateFrom: .active, to: .inactive)
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        printLog(appGoesStateFrom: .inactive, to: .background)
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        printLog(appGoesStateFrom: .background, to: .suspended)
    }
    
    // MARK: - Private Methods
    private func printLog(method: String = #function, appGoesStateFrom from: State, to: State) {
        guard showLog else { return }
        
        if from == to {
            print(
                """
                Application stays in \(from.rawValue) state:
                \(method)
                
                """
            )
        } else {
            print(
                """
                Application moved from \(from.rawValue) state to \(to.rawValue) state:
                \(method)
                
                """
            )
        }
    }
}
