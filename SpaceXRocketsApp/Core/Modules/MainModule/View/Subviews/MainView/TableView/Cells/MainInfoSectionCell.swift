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
    static let mainLabelWidth: CGFloat = (Sizes.screenWidth - Sizes.leftPadding - Sizes.rightPadding) * 1.1 / 3.0
    static let detailsLabelWidth: CGFloat = Sizes.screenWidth * 1.9 / 3.0
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
    private let mainLabel: UILabel = {
        $0.font = Fonts.tableViewCellMainLabel.uiFont
        $0.textColor = Colors.tableViewCellMainLabel.uiColor
        $0.textAlignment = .left
        $0.clipsToBounds = true
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.8
        return $0
    }(UILabel())
    
    private let detailsLabel: UILabel = {
        $0.font = Fonts.tableViewCellDetailsLabel.uiFont
        $0.textColor = Colors.tableViewCellDetailsLabel.uiColor
        $0.textAlignment = .right
        $0.clipsToBounds = true
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.8
        return $0
    }(UILabel())
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [mainLabel, detailsLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 0
        return stackView
    }()
    
    // MARK: - Init
    private override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func configureViews() {
        contentView.backgroundColor = Colors.tableViewCellBackground.uiColor
        isUserInteractionEnabled = false
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        
        applyConstraints()
    }
    
    private func applyConstraints() {
        
        let stackView = [
            stackView.heightAnchor.constraint(equalToConstant: MainInfoSectionSizeConstants.labelsHeight),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Sizes.leftPadding),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Sizes.rightPadding)
        ]
        
        let mainLabelConstraints = [
            mainLabel.widthAnchor.constraint(equalToConstant: MainInfoSectionSizeConstants.mainLabelWidth)
        ]
        
        let detailsLabelContraint = detailsLabel.widthAnchor.constraint(lessThanOrEqualToConstant: MainInfoSectionSizeConstants.detailsLabelWidth)
        detailsLabelContraint.priority = UILayoutPriority(1000)
        
        NSLayoutConstraint.activate(stackView)
        NSLayoutConstraint.activate(mainLabelConstraints)
        NSLayoutConstraint.activate([detailsLabelContraint])
    }
    
    private func updateLabels() {
        guard let viewModel = cellViewModel else { return }
        mainLabel.text = viewModel.text?.rawValue
        detailsLabel.text = viewModel.detailText
    }
}
