//
//  MainTopView.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 05.04.2022.
//

import UIKit.UIView

final class MainTopView: UIView {
    
    lazy var dragView = MainDragView()
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
        backgroundColor = Color.containerBackground.uiColor
        
        // dragView
        addSubview(dragView)
        
        dragView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dragView.topAnchor.constraint(equalTo: topAnchor),
            dragView.heightAnchor.constraint(equalToConstant: dragViewHeight),
            dragView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dragView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        // titleLabel
        titleLabel.textAlignment = .left
        titleLabel.backgroundColor = .clear
        titleLabel.font = Font.containerHeader.uiFont
        titleLabel.textColor = Color.containerHeader.uiColor
        titleLabel.text = "Falcon Heavy"
        
        addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: dragViewHeight / 2),
            titleLabel.heightAnchor.constraint(equalToConstant: 32),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        ])
    }
}
