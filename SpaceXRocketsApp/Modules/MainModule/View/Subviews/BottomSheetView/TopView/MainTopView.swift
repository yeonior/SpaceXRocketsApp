//
//  MainTopView.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 05.04.2022.
//

import UIKit.UIView

final class MainTopView: UIView {
    
    lazy var indicatorView = UIView()
    lazy var titleLabel = UILabel()
    
    let dragViewHeight: CGFloat = 20
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        // view
        backgroundColor = Color.bottomSheetViewBackground.uiColor
        
        // indicatorView
        indicatorView.backgroundColor = Color.dragIndicator.uiColor
        indicatorView.layer.cornerRadius = 2
        
        // titleLabel
        titleLabel.textAlignment = .left
        titleLabel.backgroundColor = .clear
        titleLabel.font = Font.bottomSheetViewHeader.uiFont
        titleLabel.textColor = Color.bottomSheetViewHeader.uiColor
        
        addSubview(indicatorView)
        addSubview(titleLabel)
        
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            indicatorView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            indicatorView.heightAnchor.constraint(equalToConstant: 4),
            indicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            indicatorView.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: dragViewHeight / 2),
            titleLabel.heightAnchor.constraint(equalToConstant: 32),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        ])
    }
}
