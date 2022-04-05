//
//  MainPage.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 05.04.2022.
//

import UIKit.UIViewController

final class MainViewController: UIViewController {
    
    // MARK: - Views
    private lazy var backgroundImageView: UIImageView = {
        $0.backgroundColor = .red
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView())
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Private methods
    
    private func configureUI() {
        
        // view
        view.backgroundColor = .systemBackground
        view.addSubview(backgroundImageView)
        
        // constraints
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
    }
}
