//
//  AppDelegate.swift
//  Chat-App
//
//  Created by Станислав on 19.02.2022.
//


import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Public Properties
    lazy var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        let conversationListViewController = ConversationListViewController()
        window?.rootViewController = UINavigationController(rootViewController: conversationListViewController)
        window?.makeKeyAndVisible()
        
        StorageManager.shared.fetchViaGCD(from: Constants.userInfoFileNameForSave) {
            conversationListViewController.userProfileInfo = $0
        }
        
        return true
    }
}
