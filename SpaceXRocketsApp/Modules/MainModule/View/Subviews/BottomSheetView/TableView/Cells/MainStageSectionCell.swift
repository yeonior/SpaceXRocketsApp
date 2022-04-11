//
//  MainStageSectionCell.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 07.04.2022.
//

import UIKit

final class MainStageSectionCell: MainInfoSectionCell {
    
    let unitLabel: UILabel = {
        $0.font = Font.tableViewCellUnitLabel.uiFont
        $0.textColor = Color.tableViewCellUnitLabel.uiColor
        $0.textAlignment = .right
        $0.clipsToBounds = true
        $0.text = "ton"
        
        return $0
    }(UILabel())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupLabels() {
        mainLabel.text = "Количество топлива"
        detailsLabel.text = "308,6"
        
        let subStackView = UIStackView(arrangedSubviews: [detailsLabel, unitLabel])
        subStackView.axis = .horizontal
        subStackView.distribution = .fill
        subStackView.spacing = 8
        
        let stackView = UIStackView(arrangedSubviews: [mainLabel, subStackView])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 8

        contentView.addSubview(stackView)
        
        let unitLabelConstraint = unitLabel.widthAnchor.constraint(equalToConstant: 28)
        unitLabelConstraint.priority = UILayoutPriority(753)
        let detailsLabelConstraint = detailsLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 80)
        detailsLabelConstraint.priority = UILayoutPriority(752)
        let subStackViewConstraint = subStackView.widthAnchor.constraint(greaterThanOrEqualTo: stackView.widthAnchor, multiplier: 0.3)
        subStackViewConstraint.priority = UILayoutPriority(751)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalToConstant: 24),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            mainLabel.widthAnchor.constraint(equalToConstant: (Size.screenWidth.floatValue - 32) / 2),
            mainLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            unitLabelConstraint,
            detailsLabelConstraint,
            subStackViewConstraint
        ])
    }
    
    override func updateLabels() {
        guard let _ = item as? MainInfoViewModelItem else { return }
        mainLabel.text = "Something"
        detailsLabel.text = "100"
        unitLabel.text = "kg"
    }
}
