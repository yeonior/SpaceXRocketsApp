//
//  MainFirstSectionTableViewCell.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 06.04.2022.
//

import UIKit.UITableViewCell

final class MainFirstSectionTableViewCell: UITableViewCell {
    
    let titleLabel: UILabel = {
        $0.font = Font.tableCellTitle.uiFont
        $0.textColor = Color.tableCellTitle.uiColor
        $0.textAlignment = .left
        $0.clipsToBounds = true
        $0.text = "Первый запуск"
        
        return $0
    }(UILabel())
    
    let detailTitleLabel: UILabel = {
        $0.font = Font.tableCellDetailTitle.uiFont
        $0.textColor = Color.tableCellDetailTitle.uiColor
        $0.textAlignment = .right
        $0.clipsToBounds = true
        $0.text = "7 февраля 2018"
        
        return $0
    }(UILabel())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        contentView.backgroundColor = Color.tableCell.uiColor
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, detailTitleLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        
        contentView.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalToConstant: 24),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32)
        ])
    }
}
