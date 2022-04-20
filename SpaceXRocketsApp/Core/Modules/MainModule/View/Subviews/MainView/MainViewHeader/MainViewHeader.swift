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
}

final class MainViewHeader: UIView {
    
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
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func setup() {
        
        backgroundColor = Color.mainViewHeaderBackground.uiColor
        
//        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
//        addSubview(indicatorView)
        addSubview(titleLabel)
        
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
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                 constant: -MainViewSizeConstants.rightPadding)
        ])
    }
}
