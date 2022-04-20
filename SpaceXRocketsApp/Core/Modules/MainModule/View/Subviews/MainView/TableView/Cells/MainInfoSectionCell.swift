//
//  MainFirstSectionTableViewCell.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 06.04.2022.
//

import UIKit

protocol MainCellProtocol {
    var cellViewModel: MainTableViewCellViewModelProtocol? { get }
}

private struct MainInfoSectionSizeConstants {
    static let mainLabelWidth: CGFloat = (Size.screenWidth.floatValue - MainViewSizeConstants.leftPadding - MainViewSizeConstants.rightPadding) * 1.1 / 3.0
    static let detailsLabelWidth: CGFloat = Size.screenWidth.floatValue * 1.9 / 3.0
    static let labelsHeight: CGFloat = 24.0
}

final class MainInfoSectionCell: UITableViewCell, MainCellProtocol {
    
    // MARK: - Properties
    static let identifier = "infoCell"
    
    var cellViewModel: MainTableViewCellViewModelProtocol? {
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
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.8
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
    
    // MARK: - Init
    private override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
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
        
        let stackView = UIStackView(arrangedSubviews: [mainLabel, detailsLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 0
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)
        
        let detailsLabelContraint = detailsLabel.widthAnchor.constraint(lessThanOrEqualToConstant: MainInfoSectionSizeConstants.detailsLabelWidth)
        detailsLabelContraint.priority = UILayoutPriority(1000)
        
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalToConstant: MainInfoSectionSizeConstants.labelsHeight),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: MainViewSizeConstants.leftPadding),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -MainViewSizeConstants.rightPadding),
            mainLabel.widthAnchor.constraint(equalToConstant: MainInfoSectionSizeConstants.mainLabelWidth),
            detailsLabelContraint
        ])
    }
    
    private func updateLabels() {
        guard let viewModel = cellViewModel else { return }
        mainLabel.text = viewModel.text?.rawValue
        detailsLabel.text = viewModel.detailText
    }
}
