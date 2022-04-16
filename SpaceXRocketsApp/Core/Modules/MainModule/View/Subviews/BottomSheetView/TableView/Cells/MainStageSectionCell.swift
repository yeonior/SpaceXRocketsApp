//
//  MainStageSectionCell.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 07.04.2022.
//

import UIKit

final class MainStageSectionCell: UITableViewCell, MainCellProtocol {
    
    // MARK: - Properties
    static let identifier = "stageCell"
    
    var cellViewModel: MainCellViewModelProtocol? {
        didSet {
            updateLabels()
        }
    }
    
    // MARK: - Subviews
    lazy var mainLabel: UILabel = {
        $0.font = Font.tableViewCellMainLabel.uiFont
        $0.textColor = Color.tableViewCellMainLabel.uiColor
        $0.textAlignment = .left
        $0.clipsToBounds = true
        return $0
    }(UILabel())
    
    lazy var detailsLabel: UILabel = {
        $0.font = Font.tableViewCellDetailsLabel.uiFont
        $0.textColor = Color.tableViewCellDetailsLabel.uiColor
        $0.textAlignment = .right
        $0.clipsToBounds = true
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.8
        return $0
    }(UILabel())
    
    let unitLabel: UILabel = {
        $0.font = Font.tableViewCellUnitLabel.uiFont
        $0.textColor = Color.tableViewCellUnitLabel.uiColor
        $0.textAlignment = .right
        $0.clipsToBounds = true
        return $0
    }(UILabel())
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func setupView() {
        contentView.backgroundColor = Color.tableViewCellBackground.uiColor
        isUserInteractionEnabled = false
    }
    
    private func setupLabels() {
        
        let subStackView = UIStackView(arrangedSubviews: [detailsLabel, unitLabel])
        subStackView.axis = .horizontal
        subStackView.distribution = .fill
        subStackView.spacing = 4
        
        let stackView = UIStackView(arrangedSubviews: [mainLabel, subStackView])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 8
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)
        
        let unitLabelConstraint = unitLabel.widthAnchor.constraint(equalToConstant: 28)
        unitLabelConstraint.priority = UILayoutPriority(753)
        let detailsLabelConstraint = detailsLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 80)
        detailsLabelConstraint.priority = UILayoutPriority(752)
        let subStackViewConstraint = subStackView.widthAnchor.constraint(greaterThanOrEqualTo: stackView.widthAnchor, multiplier: 0.3)
        subStackViewConstraint.priority = UILayoutPriority(751)
        
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalToConstant: 24),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            mainLabel.widthAnchor.constraint(equalToConstant: (Size.screenWidth.floatValue) / 2),
            mainLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            unitLabelConstraint,
            detailsLabelConstraint,
            subStackViewConstraint
        ])
    }
    
    private func updateLabels() {
        guard let viewModel = cellViewModel else { return }
        mainLabel.text = viewModel.text?.rawValue
        detailsLabel.text = viewModel.detailText
        unitLabel.text = viewModel.unit
    }
}
