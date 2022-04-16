//
//  DetailsCell.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 12.04.2022.
//

import UIKit

protocol DetailsCellProtocol {
    var cellViewModel: DetailsCellViewModelProtocol? { get }
}

// MARK: Cell size constants
struct DetailsCellSizeConstants {
    static let distanceToBorder: CGFloat = UIScreen.main.bounds.width * 0.08
    static let minimumLineSpacing: CGFloat = UIScreen.main.bounds.width * 0.05
    static let itemWidth: CGFloat = UIScreen.main.bounds.width - 64
}

final class DetailsCell: UICollectionViewCell, DetailsCellProtocol {
    
    static let identifier = "DetailsCell"
    
    var successSign: Bool?
    var cellViewModel: DetailsCellViewModelProtocol? {
        didSet {
            updateLabels()
        }
    }
    
    // MARK: - Subviews
    lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.font = Font.collectionCellMainLabel.uiFont
        label.textAlignment = .left
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.clipsToBounds = true
        label.textColor = Color.collectionCellMainLabel.uiColor
        
        return label
    }()
    
    lazy var detailsLabel: UILabel = {
        let label = UILabel()
        label.font = Font.collectionCellDetailLabel.uiFont
        label.textAlignment = .left
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.clipsToBounds = true
        label.textColor = Color.collectionCellDetailsLabel.uiColor
        
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private let circleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = Color.circleBackground.uiColor
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    lazy var statusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
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
        
        let labelStackView = UIStackView(arrangedSubviews: [mainLabel, detailsLabel])
        labelStackView.distribution = .fill
        labelStackView.axis = .vertical
        
        // attributes
        contentView.backgroundColor = Color.collectionCellBackground.uiColor
        contentView.layer.cornerRadius = 24
//        contentView.layer.shadowRadius = 7
//        contentView.layer.shadowOpacity = 0.3
//        contentView.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        contentView.addSubview(labelStackView)
        contentView.addSubview(imageView)
        contentView.addSubview(circleImageView)
        contentView.addSubview(statusImageView)
        
        // constraints
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        circleImageView.translatesAutoresizingMaskIntoConstraints = false
        statusImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            labelStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            labelStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            labelStackView.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -10),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            circleImageView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            circleImageView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            circleImageView.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 0.3),
            circleImageView.widthAnchor.constraint(equalTo: statusImageView.heightAnchor),
            statusImageView.leadingAnchor.constraint(equalTo: circleImageView.leadingAnchor, constant: -2),
            statusImageView.trailingAnchor.constraint(equalTo: circleImageView.trailingAnchor, constant: 2),
            statusImageView.topAnchor.constraint(equalTo: circleImageView.topAnchor, constant: -2),
            statusImageView.bottomAnchor.constraint(equalTo: circleImageView.bottomAnchor, constant: 2)
        ])
    }
    
    private func updateLabels() {
        
        guard let viewModel = cellViewModel else { return }
        mainLabel.text = viewModel.text
        detailsLabel.text = viewModel.detailText
        
        guard let success = viewModel.sign else {
            imageView.image = UIImage(systemName: "questionmark.circle.fill")
            imageView.tintColor = Color.collectionCellImageView.uiColor
            statusImageView.image = nil
            circleImageView.image = nil
            return
        }
        
        imageView.image = success ? UIImage(named: "spaceRocket")?.withTintColor(Color.collectionCellImageView.uiColor) : UIImage(named: "spaceRocket")?.withTintColor(Color.collectionCellImageView.uiColor).flipDiagonally()
        circleImageView.image = UIImage(systemName: "circle.fill")
        statusImageView.image = success ? UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: "xmark.circle.fill")
        statusImageView.tintColor = success ? Color.successStatus.uiColor : Color.failureStatus.uiColor
    }
}
