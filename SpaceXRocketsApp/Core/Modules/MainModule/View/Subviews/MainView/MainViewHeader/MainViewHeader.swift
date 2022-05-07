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

final class MainViewHeader: UIView {
    
    // MARK: - Properties
    var buttonAction: Callback?
    
    // MARK: - Subviews
//    lazy var indicatorView: UIView = {
//        $0.backgroundColor = Color.dragIndicator.uiColor
//        $0.layer.cornerRadius = 2
//        return $0
//    }(UIView())
    
    lazy var titleLabel: UILabel = {
        $0.textAlignment = .left
        $0.backgroundColor = .clear
        $0.font = Font.mainViewHeader.uiFont
        $0.textColor = Color.mainViewHeader.uiColor
        return $0
    }(UILabel())
    
    lazy var settingsButton: UIButton = {
        $0.imageView?.tintColor = .white
        $0.imageView?.contentMode = .scaleAspectFit
        $0.contentVerticalAlignment = .fill
        $0.contentHorizontalAlignment = .fill
        $0.isUserInteractionEnabled = false
        return $0
    }(UIButton())
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func setup() {
        
        backgroundColor = Color.mainViewHeaderBackground.uiColor
        settingsButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
//        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        
//        addSubview(indicatorView)
        addSubview(titleLabel)
        addSubview(settingsButton)
        
        // constraints
        NSLayoutConstraint.activate([
//            indicatorView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
//            indicatorView.heightAnchor.constraint(equalToConstant: 4),
//            indicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
//            indicatorView.widthAnchor.constraint(equalToConstant: 50),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor,
                                                constant: MainViewHeaderSizeConstants.titleLabelYOffset),
            titleLabel.heightAnchor.constraint(equalToConstant: MainViewHeaderSizeConstants.titleLabelHeight),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                constant: MainViewSizeConstants.leftPadding),
            titleLabel.trailingAnchor.constraint(equalTo: settingsButton.leadingAnchor,
                                                 constant: -MainViewHeaderSizeConstants.spacingBetweenLabelAndButton),
            settingsButton.heightAnchor.constraint(equalTo: titleLabel.heightAnchor),
            settingsButton.widthAnchor.constraint(equalTo: settingsButton.heightAnchor),
            settingsButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            settingsButton.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                     constant: -MainViewSizeConstants.rightPadding)
        ])
    }
    
    func activateButton() {
        settingsButton.setImage(UIImage(systemName: "gearshape"), for: .normal)
        settingsButton.isUserInteractionEnabled = true
    }
    
    @objc
    private func didTapButton() {
        buttonAction?()
    }
}
