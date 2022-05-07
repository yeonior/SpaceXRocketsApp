//
//  SettingsView.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 29.04.2022.
//

import UIKit

final class SettingsView: UIView {

    // MARK: - Subviews
    lazy var stackView = UIStackView()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup(with: 4)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func setup(with number: Int) {
        var arrangedSubviews: [UIView] = []
        for _ in 1...number {
            arrangedSubviews.append(SettingsItemView())
        }
        stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = .vertical
        stackView.spacing = SettingsViewSizeConstants.spacingItems
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
