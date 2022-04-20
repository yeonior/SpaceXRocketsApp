//
//  MainSectionHeader.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 07.04.2022.
//

import UIKit

final class MainSectionHeader: UITableViewHeaderFooterView {
    
    // MARK: - Properties
    static let identifier = "sectionHeader"
    
    // MARK: - Subviews
    let titleLabel: UILabel = {
        $0.font = Font.tableViewStageSectionHeader.uiFont
        $0.textColor = Color.tableViewStageSectionHeader.uiColor
        $0.textAlignment = .left
        $0.clipsToBounds = true
        return $0
    }(UILabel())
    
    // MARK: - Init
    private override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func setup() {
        
        contentView.backgroundColor = Color.tableViewCellBackground.uiColor
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                constant: MainViewSizeConstants.leftPadding),
            titleLabel.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor,
                                                constant: -MainViewSizeConstants.rightPadding)
        ])
    }
}
