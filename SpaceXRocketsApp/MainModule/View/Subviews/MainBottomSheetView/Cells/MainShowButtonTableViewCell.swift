//
//  MainShowButtonTableViewCell.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 07.04.2022.
//

import UIKit

final class MainShowButtonTableViewCell: UITableViewCell {
    
    let showButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        backgroundColor = Color.tableCell.uiColor
        
        showButton.layer.cornerRadius = 10
        showButton.backgroundColor = Color.showButton.uiColor
        showButton.titleLabel?.font = Font.showButton.uiFont
        showButton.titleLabel?.textColor = .white
        showButton.setTitle("Посмотреть запуски", for: .normal)
        
        contentView.addSubview(showButton)
        
        showButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            showButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            showButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            showButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            showButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32)
        ])
    }
}
