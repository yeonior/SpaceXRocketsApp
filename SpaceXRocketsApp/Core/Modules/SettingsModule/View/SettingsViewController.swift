//
//  SettingsViewController.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 25.04.2022.
//

import UIKit

protocol SettingsViewProtocol: AnyObject {
    
}

final class SettingsViewController: UIViewController {
    
    // MARK: - Subviews
    
    // MARK: - Properties
    var presenter: SettingsPresenter!
    var router: Routing!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Private methods
    private func configureUI() {
        title = "Settings"
        view.backgroundColor = Color.settingsBackground.uiColor
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Close", style: .done, target: nil, action: nil)
    }
}

// MARK: - SettingsViewProtocol
extension SettingsViewController: SettingsViewProtocol {
    
}
