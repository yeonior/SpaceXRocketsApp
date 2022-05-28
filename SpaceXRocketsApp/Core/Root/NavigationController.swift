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
        configureUI()
    }
    
    // MARK: - Methods
    private func configureUI() {
        let textAttributes = [NSAttributedString.Key.foregroundColor: Color.navigationBarTitleColor.uiColor]
        navigationBar.titleTextAttributes = textAttributes
        navigationBar.barTintColor = Color.navigationBarColor.uiColor
        navigationBar.tintColor = Color.navigationBarButtonColor.uiColor
    }
}
