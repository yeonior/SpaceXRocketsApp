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
        backgroundColor = .systemBrown
        
        // dragView
        dragView.backgroundColor = .systemGray
        
        addSubview(dragView)
        
        dragView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dragView.topAnchor.constraint(equalTo: topAnchor),
            dragView.heightAnchor.constraint(equalToConstant: dragViewHeight),
            dragView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dragView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        // titleLabel
        titleLabel.backgroundColor = .systemPurple
        titleLabel.font = .systemFont(ofSize: 30)
        titleLabel.text = "Saegewegwwgeewg"
        
        addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: dragViewHeight / 2),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
}
