//
//  MainViewHeader.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 05.04.2022.
//

import UIKit

private struct MainViewHeaderSizeConstants {
    static let titleLabelHeight: CGFloat = 32.0
    static let titleLabelYOffset: CGFloat = 8.0
    static let spacingBetweenLabelAndButton: CGFloat = 8.0
}

typealias Callback = () -> Void

final class MainViewHeader: UIView {
    
    // MARK: - Properties
    var buttonAction: Callback?
    
    // MARK: - Subviews
    lazy var titleLabel: UILabel = {
        $0.textAlignment = .left
        $0.backgroundColor = .clear
        $0.font = Fonts.mainViewHeader.uiFont
        $0.textColor = Colors.mainViewHeader.uiColor
        return $0
    }(UILabel())
    
    private let settingsButton: UIButton = {
        $0.setImage(UIImage(systemName: "gearshape"), for: .normal)
        $0.imageView?.tintColor = Colors.settingsButton.uiColor
        $0.imageView?.contentMode = .scaleAspectFit
        $0.contentVerticalAlignment = .fill
        $0.contentHorizontalAlignment = .fill
        return $0
    }(UIButton())
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func configureViews() {
        
        backgroundColor = Colors.mainViewHeaderBackground.uiColor
        settingsButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleLabel)
        addSubview(settingsButton)
        
        applyConstraints()
    }
    
    private func applyConstraints() {
        
        let titleLabelConstraints = [
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor,
                                                constant: MainViewHeaderSizeConstants.titleLabelYOffset),
            titleLabel.heightAnchor.constraint(equalToConstant: MainViewHeaderSizeConstants.titleLabelHeight),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                constant: Sizes.leftPadding),
            titleLabel.trailingAnchor.constraint(equalTo: settingsButton.leadingAnchor,
                                                 constant: -MainViewHeaderSizeConstants.spacingBetweenLabelAndButton)
        ]
        
        let settingsButtonConstraints = [
            settingsButton.heightAnchor.constraint(equalTo: titleLabel.heightAnchor),
            settingsButton.widthAnchor.constraint(equalTo: settingsButton.heightAnchor),
            settingsButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            settingsButton.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                     constant: -Sizes.rightPadding)
        ]
        
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(settingsButtonConstraints)
    }
    
    @objc
    private func didTapButton() {
        buttonAction?()
    }
}
