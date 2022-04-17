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

private struct DetailsCellSizeConstants {
    static let cornerRadius: CGFloat = 24.0
    static let labelsLeftPadding: CGFloat = 24.0
    static let labelsRightPadding: CGFloat = 10.0
    static let imageViewRightPadding: CGFloat = 24.0
}

final class DetailsCell: UICollectionViewCell, DetailsCellProtocol {
    
    // MARK: - Properties
    static let identifier = "detailsCell"
    
    var cellViewModel: DetailsCellViewModelProtocol? {
        didSet {
            updateLabels()
        }
    }
    private var successSign: Bool?
    
    // MARK: - Subviews
    lazy var mainLabel: UILabel = {
        $0.font = Font.collectionCellMainLabel.uiFont
        $0.textColor = Color.collectionCellMainLabel.uiColor
        $0.textAlignment = .left
        $0.numberOfLines = 1
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.8
        $0.clipsToBounds = true
        return $0
    }(UILabel())
    
    lazy var detailsLabel: UILabel = {
        $0.font = Font.collectionCellDetailLabel.uiFont
        $0.textColor = Color.collectionCellDetailsLabel.uiColor
        $0.textAlignment = .left
        $0.numberOfLines = 1
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.7
        $0.clipsToBounds = true
        return $0
    }(UILabel())
    
    lazy var imageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    private lazy var circleImageView: UIImageView = {
        $0.tintColor = Color.collectionViewCellCircleBackground.uiColor
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    lazy var statusImageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
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
        
        let labelsStackView = UIStackView(arrangedSubviews: [mainLabel, detailsLabel])
        labelsStackView.distribution = .fill
        labelsStackView.axis = .vertical
        
        contentView.backgroundColor = Color.collectionCellBackground.uiColor
        contentView.layer.cornerRadius = DetailsCellSizeConstants.cornerRadius
//        contentView.layer.shadowRadius = 7
//        contentView.layer.shadowOpacity = 0.3
//        contentView.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        circleImageView.translatesAutoresizingMaskIntoConstraints = false
        statusImageView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(labelsStackView)
        contentView.addSubview(imageView)
        contentView.addSubview(circleImageView)
        contentView.addSubview(statusImageView)
        
        // constraints
        NSLayoutConstraint.activate([
            labelsStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            labelsStackView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                     constant: DetailsCellSizeConstants.labelsLeftPadding),
            labelsStackView.trailingAnchor.constraint(equalTo: imageView.leadingAnchor,
                                                      constant: -DetailsCellSizeConstants.labelsRightPadding),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -DetailsCellSizeConstants.imageViewRightPadding),
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
        
        imageView.image = success
                          ? UIImage(named: "spaceRocket")?.withTintColor(Color.collectionCellImageView.uiColor)
                          : UIImage(named: "spaceRocket")?.withTintColor(Color.collectionCellImageView.uiColor).flipDiagonally()
        circleImageView.image = UIImage(systemName: "circle.fill")
        statusImageView.image = success
                                ? UIImage(systemName: "checkmark.circle.fill")
                                : UIImage(systemName: "xmark.circle.fill")
        statusImageView.tintColor = success
                                    ? Color.successStatus.uiColor
                                    : Color.failureStatus.uiColor
    }
}
