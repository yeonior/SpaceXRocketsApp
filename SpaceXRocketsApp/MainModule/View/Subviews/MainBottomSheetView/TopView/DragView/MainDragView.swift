//
//  MainDragView.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 05.04.2022.
//

import UIKit.UIView

final class MainDragView: UIView {
    
    lazy var indicatorView = UIView()
    
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
        
        // indicatorView
        indicatorView.backgroundColor = Color.dragIndicator.uiColor
        indicatorView.layer.cornerRadius = 3
        
        addSubview(indicatorView)
        
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            indicatorView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            indicatorView.heightAnchor.constraint(equalToConstant: 4),
            indicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            indicatorView.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
}
