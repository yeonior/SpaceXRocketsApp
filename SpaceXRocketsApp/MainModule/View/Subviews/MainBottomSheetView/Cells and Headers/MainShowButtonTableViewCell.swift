//
//  MainShowButtonTableViewCell.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 07.04.2022.
//

import UIKit

final class MainShowButtonTableViewCell: UITableViewCell {
    
    let showButton = UIButton()
    let baseView = UIView()
    var buttonTapCallback: () -> () = {
        print("button tapped")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        baseView.backgroundColor = Color.tableCell.uiColor
        
        showButton.layer.cornerRadius = 14
        showButton.backgroundColor = Color.showButton.uiColor
        showButton.titleLabel?.font = Font.showButton.uiFont
        showButton.titleLabel?.textColor = .white
        showButton.setTitle("Посмотреть запуски", for: .normal)
        showButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        contentView.addSubview(baseView)
        baseView.addSubview(showButton)
        
        baseView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            baseView.topAnchor.constraint(equalTo: contentView.topAnchor),
            baseView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            baseView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            baseView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        showButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            showButton.topAnchor.constraint(equalTo: baseView.topAnchor),
            showButton.bottomAnchor.constraint(equalTo: baseView.bottomAnchor),
            showButton.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 32),
            showButton.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -32)
        ])
    }
    
    @objc
    private func didTapButton() {
        buttonTapCallback()
    }
}
