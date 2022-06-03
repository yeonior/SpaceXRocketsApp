//
//  MainCollectionViewCell.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 17.04.2022.
//

import UIKit

protocol MainCollectionViewCellProtocol {
    var cellViewModel: MainCollectionViewCellViewModelProtocol? { get }
}

private struct MainCollectionCellSizeConstants {
    static let cornerRadius: CGFloat = 32.0
    static let labelsTopPadding: CGFloat = 28.0
    static let labelsBottomPadding: CGFloat = 24.0
    static let labelsLeftPadding: CGFloat = 8.0
    static let labelsRightPadding: CGFloat = 8.0
}

final class MainCollectionViewCell: UICollectionViewCell, MainCollectionViewCellProtocol {
    
    // MARK: - Properties
    static let identifier = "mainCollectionViewCell"
    
    var cellViewModel: MainCollectionViewCellViewModelProtocol? {
        didSet {
            updateLabels()
        }
    }
    
    // MARK: - Subviews
    lazy var mainLabel: UILabel = {
        $0.font = Fonts.mainCollectionCellMainLabel.uiFont
        $0.textColor = Colors.mainCollectionCellMainLabel.uiColor
        $0.textAlignment = .center
        $0.numberOfLines = 1
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.8
        $0.clipsToBounds = true
        return $0
    }(UILabel())
    
    lazy var detailsLabel: UILabel = {
        $0.font = Fonts.mainCollectionCellDetailsLabel.uiFont
        $0.textColor = Colors.mainCollectionCellDetailsLabel.uiColor
        $0.textAlignment = .center
        $0.numberOfLines = 1
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.7
        $0.clipsToBounds = true
        return $0
    }(UILabel())
    
    // MARK: - Init
    private override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func configureViews() {
        
        contentView.backgroundColor = Colors.detailsCollectionCellBackground.uiColor
        contentView.layer.cornerRadius = MainCollectionCellSizeConstants.cornerRadius
        
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        detailsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(mainLabel)
        contentView.addSubview(detailsLabel)
        
        applyConstraints()
    }
    
    private func applyConstraints() {
        
        let mainLabelConstraints = [
            mainLabel.topAnchor.constraint(equalTo: topAnchor,
                                           constant: MainCollectionCellSizeConstants.labelsTopPadding),
            mainLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                               constant: MainCollectionCellSizeConstants.labelsLeftPadding),
            mainLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                constant: -MainCollectionCellSizeConstants.labelsRightPadding)
        ]
        
        let detailsLabelConstraints = [
            detailsLabel.bottomAnchor.constraint(equalTo: bottomAnchor,
                                                 constant: -MainCollectionCellSizeConstants.labelsBottomPadding),
            detailsLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                  constant: MainCollectionCellSizeConstants.labelsLeftPadding),
            detailsLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                   constant: -MainCollectionCellSizeConstants.labelsRightPadding)
        ]
        
        NSLayoutConstraint.activate(mainLabelConstraints)
        NSLayoutConstraint.activate(detailsLabelConstraints)
    }
    
    private func updateLabels() {
        guard let viewModel = cellViewModel else { return }
        mainLabel.text = viewModel.text
        detailsLabel.text = viewModel.detailText
    }
}
