//
//  SceneDelegate.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 05.04.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let navigationViewController = NavigationController()
        let assemblyBuilder = AssemblyBuilder()
        let router = Router(navigationController: navigationViewController,
                            assemblyBuilder: assemblyBuilder)
        router.activateBaseModule()
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = navigationViewController
        window?.makeKeyAndVisible()
    }
}

