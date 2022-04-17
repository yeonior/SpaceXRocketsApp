//
//  NavigationController.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 16.04.2022.
//

import UIKit

final class NavigationController: UINavigationController {
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Methods
    private func configure() {
        let textAttributes = [NSAttributedString.Key.foregroundColor: Color.mainViewHeader.uiColor]
        navigationBar.titleTextAttributes = textAttributes
        navigationBar.barTintColor = Color.background.uiColor
        navigationBar.tintColor = Color.mainViewHeader.uiColor
    }
}
