//
//  MainCollectionCell.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 17.04.2022.
//

import UIKit

protocol MainCollectionCellProtocol {
    var cellViewModel: MainCollectionCellViewModelProtocol? { get }
}

final class MainCollectionCell: UICollectionViewCell, MainCollectionCellProtocol {
    
    // MARK: - Properties
    static let identifier = "mainCollectionViewCell"
    
    var cellViewModel: MainCollectionCellViewModelProtocol? {
        didSet {
            updateLabels()
        }
    }
    
    // MARK: - Subviews
    lazy var mainLabel: UILabel = {
        $0.font = Font.mainCollectionCellMainLabel.uiFont
        $0.textColor = Color.mainCollectionCellMainLabel.uiColor
        $0.textAlignment = .center
        $0.numberOfLines = 1
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.8
        $0.clipsToBounds = true
        return $0
    }(UILabel())
    
    lazy var detailsLabel: UILabel = {
        $0.font = Font.mainCollectionCellDetailsLabel.uiFont
        $0.textColor = Color.mainCollectionCellDetailsLabel.uiColor
        $0.textAlignment = .center
        $0.numberOfLines = 1
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.7
        $0.clipsToBounds = true
        return $0
    }(UILabel())
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func setupLabels() {
        
        contentView.backgroundColor = Color.detailsCollectionCellBackground.uiColor
        contentView.layer.cornerRadius = 32
        
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        detailsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(mainLabel)
        contentView.addSubview(detailsLabel)
        
        // constraints
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: topAnchor, constant: 28),
            mainLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            mainLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            detailsLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
            detailsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            detailsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    
    private func updateLabels() {
        guard let viewModel = cellViewModel else { return }
        mainLabel.text = viewModel.text
        detailsLabel.text = viewModel.detailText
    }
}
