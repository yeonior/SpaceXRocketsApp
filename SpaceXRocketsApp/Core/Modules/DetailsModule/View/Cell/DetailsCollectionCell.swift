//
//  DetailsCollectionCell.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 12.04.2022.
//

import UIKit

protocol DetailsCollectionCellProtocol {
    var cellViewModel: DetailsCollectionCellViewModelProtocol? { get }
}

private struct DetailsCellSizeConstants {
    static let cornerRadius: CGFloat = 24.0
    static let labelsLeftPadding: CGFloat = 24.0
    static let labelsRightPadding: CGFloat = 10.0
    static let imageViewRightPadding: CGFloat = 24.0
}

final class DetailsCollectionCell: UICollectionViewCell, DetailsCollectionCellProtocol {
    
    // MARK: - Properties
    static let identifier = "detailsCell"
    
    var cellViewModel: DetailsCollectionCellViewModelProtocol? {
        didSet {
            updateLabels()
        }
    }
    private var successSign: Bool?
    
    // MARK: - Subviews
    let mainLabel: UILabel = {
        $0.font = Font.detailsCollectionCellMainLabel.uiFont
        $0.textColor = Color.detailsCollectionCellMainLabel.uiColor
        $0.textAlignment = .left
        $0.numberOfLines = 1
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.8
        $0.clipsToBounds = true
        return $0
    }(UILabel())
    
    private let detailsLabel: UILabel = {
        $0.font = Font.detailsCollectionCellDetailLabel.uiFont
        $0.textColor = Color.detailsCollectionCellDetailsLabel.uiColor
        $0.textAlignment = .left
        $0.numberOfLines = 1
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.7
        $0.clipsToBounds = true
        return $0
    }(UILabel())
    
    let imageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    private let circleImageView: UIImageView = {
        $0.tintColor = Color.detailsCollectionViewCellCircleBackground.uiColor
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    private let statusImageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [mainLabel, detailsLabel])
        stackView.distribution = .fill
        stackView.axis = .vertical
        return stackView
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func configureViews() {
        contentView.backgroundColor = Color.detailsCollectionCellBackground.uiColor
        contentView.layer.cornerRadius = DetailsCellSizeConstants.cornerRadius
        
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        circleImageView.translatesAutoresizingMaskIntoConstraints = false
        statusImageView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(labelsStackView)
        contentView.addSubview(imageView)
        contentView.addSubview(circleImageView)
        contentView.addSubview(statusImageView)
        
        applyConstraints()
    }
    
    private func applyConstraints() {
        
        let labelsStackViewConstraints = [
            labelsStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            labelsStackView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                     constant: DetailsCellSizeConstants.labelsLeftPadding),
            labelsStackView.trailingAnchor.constraint(equalTo: imageView.leadingAnchor,
                                                      constant: -DetailsCellSizeConstants.labelsRightPadding)
        ]
        
        let imageViewConstraints = [
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -DetailsCellSizeConstants.imageViewRightPadding),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        
        let circleImageViewConstraints = [
            circleImageView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            circleImageView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            circleImageView.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 0.3),
            circleImageView.widthAnchor.constraint(equalTo: statusImageView.heightAnchor),
        ]
        
        let statusImageViewConstraints = [
            statusImageView.leadingAnchor.constraint(equalTo: circleImageView.leadingAnchor, constant: -2),
            statusImageView.trailingAnchor.constraint(equalTo: circleImageView.trailingAnchor, constant: 2),
            statusImageView.topAnchor.constraint(equalTo: circleImageView.topAnchor, constant: -2),
            statusImageView.bottomAnchor.constraint(equalTo: circleImageView.bottomAnchor, constant: 2)
        ]
        
        NSLayoutConstraint.activate(labelsStackViewConstraints)
        NSLayoutConstraint.activate(imageViewConstraints)
        NSLayoutConstraint.activate(circleImageViewConstraints)
        NSLayoutConstraint.activate(statusImageViewConstraints)
    }
    
    private func updateLabels() {
        
        guard let viewModel = cellViewModel else { return }
        mainLabel.text = viewModel.text
        detailsLabel.text = viewModel.detailText
        
        guard let success = viewModel.sign else {
            imageView.image = UIImage(systemName: "questionmark.circle.fill")
            imageView.tintColor = Color.detailsCollectionCellImageView.uiColor
            statusImageView.image = nil
            circleImageView.image = nil
            return
        }
        
        imageView.image = success
                          ? UIImage(named: "spaceRocket")?.withTintColor(Color.detailsCollectionCellImageView.uiColor)
                          : UIImage(named: "spaceRocket")?.withTintColor(Color.detailsCollectionCellImageView.uiColor).flipDiagonally()
        circleImageView.image = UIImage(systemName: "circle.fill")
        statusImageView.image = success
                                ? UIImage(systemName: "checkmark.circle.fill")
                                : UIImage(systemName: "xmark.circle.fill")
        statusImageView.tintColor = success
                                    ? Color.successStatus.uiColor
                                    : Color.failureStatus.uiColor
    }
}
