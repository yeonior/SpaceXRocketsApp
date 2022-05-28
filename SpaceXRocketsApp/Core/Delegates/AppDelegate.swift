//
//  AppDelegate.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 05.04.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Properties
    let dataManager = DataManager.shared
    
    // MARK: - UIApplicationDelegate methods
    
    // customization after app launch
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // configuring app at the first run
        if !dataManager.getAppFirstRunStatus() {
            dataManager.setAppFirstRunStatus()
            dataManager.setDefaultUnits()
        }
        
        return true
    }
    
    // retrieving the configuration data
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    // setting interface orientation to portrait mode
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        .portrait
    }
}
