//
//  MainTableViewSectionHeader.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 07.04.2022.
//

import UIKit

final class MainTableViewSectionHeader: UITableViewHeaderFooterView {
    
    let titleLabel = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        contentView.backgroundColor = Color.tableViewCellBackground.uiColor
        
        titleLabel.font = Font.tableViewStageSectionHeader.uiFont
        titleLabel.textColor = Color.tableViewStageSectionHeader.uiColor
        titleLabel.textAlignment = .left
        titleLabel.clipsToBounds = true
        titleLabel.text = "ПЕРВАЯ СТУПЕНЬ"
        
        contentView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32)
        ])
    }
}
