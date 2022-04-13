//
//  DetailsCell.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 12.04.2022.
//

import UIKit

// MARK: Cell size constants
struct MainCellSizeConstants {
    static let distanceToBorder: CGFloat = UIScreen.main.bounds.width * 0.08
    static let minimumLineSpacing: CGFloat = UIScreen.main.bounds.width * 0.05
    static let itemWidth: CGFloat = UIScreen.main.bounds.width - 64
//    (UIScreen.main.bounds.width - distanceToBorder * 2 - minimumLineSpacing) / 1.3
}

final class DetailsCell: UICollectionViewCell {
    
    static let identifier = "MainCell"
    
    // MARK: - Subviews
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "FalconSat"
        label.font = Font.collectionCellMainLabel.uiFont
        label.textAlignment = .left
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.clipsToBounds = true
        label.textColor = Color.collectionCellMainLabel.uiColor
        
        return label
    }()
    
    private let detailsLabel: UILabel = {
        let label = UILabel()
        label.text = "02/04/2022"
        label.font = Font.collectionCellDetailLabel.uiFont
        label.textAlignment = .left
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.clipsToBounds = true
        label.textColor = Color.collectionCellDetailsLabel.uiColor
        
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrow.up.forward")
        imageView.tintColor = Color.collectionCellImageView.uiColor
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private let circleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "circle.fill")
        imageView.tintColor = Color.circleBackground.uiColor
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private let statusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark.circle.fill")
        imageView.tintColor = Color.successStatus.uiColor
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
    
    func setupLabels() {
        
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
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            circleImageView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -4),
            circleImageView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -4),
            circleImageView.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 0.3),
            circleImageView.widthAnchor.constraint(equalTo: statusImageView.heightAnchor),
            statusImageView.leadingAnchor.constraint(equalTo: circleImageView.leadingAnchor, constant: -2),
            statusImageView.trailingAnchor.constraint(equalTo: circleImageView.trailingAnchor, constant: 2),
            statusImageView.topAnchor.constraint(equalTo: circleImageView.topAnchor, constant: -2),
            statusImageView.bottomAnchor.constraint(equalTo: circleImageView.bottomAnchor, constant: 2)
        ])
    }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//    
//    }
}
