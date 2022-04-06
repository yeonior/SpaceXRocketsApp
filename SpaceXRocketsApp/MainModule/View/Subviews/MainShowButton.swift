//
//  MainShowButton.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 06.04.2022.
//

import UIKit.UIButton

final class MainShowButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    private func setup() {
        layer.cornerRadius = 10
        backgroundColor = Color.showButton.uiColor
        titleLabel?.font = Font.showButton.uiFont
        titleLabel?.textColor = .white
        setTitle("Посмотреть запуски", for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
