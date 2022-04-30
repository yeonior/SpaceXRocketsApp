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
    lazy var settingsView = SettingsView()
    
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Close",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(closeView))
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Color.navigationBarTitleColor.uiColor]
        view.backgroundColor = Color.settingsBackground.uiColor
        navigationItem.rightBarButtonItem?.tintColor = Color.navigationBarButtonColor.uiColor
        
        settingsView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(settingsView)
        
        NSLayoutConstraint.activate([
            settingsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            settingsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            settingsView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            settingsView.widthAnchor.constraint(equalTo: view.widthAnchor),
            settingsView.heightAnchor.constraint(equalToConstant: 216)
        ])
    }
    
    @objc
    private func closeView() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - SettingsViewProtocol
extension SettingsViewController: SettingsViewProtocol {
    
}
