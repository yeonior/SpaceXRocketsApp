//
//  MainFirstSectionTableViewCell.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 06.04.2022.
//

import UIKit

protocol MainCellProtocol {
    var cellViewModel: MainCellViewModelProtocol? { get }
}

class MainInfoSectionCell: UITableViewCell, MainCellProtocol {
    
    var cellViewModel: MainCellViewModelProtocol? {
        didSet {
            updateLabels()
        }
    }
    
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.backgroundColor = Color.tableViewCellBackground.uiColor
        isUserInteractionEnabled = false
    }
    
    func setupLabels() {
        
        let stackView = UIStackView(arrangedSubviews: [mainLabel, detailsLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 0
        
        contentView.addSubview(stackView)
        
        let detailsLabelContraint = detailsLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 230)
        detailsLabelContraint.priority = UILayoutPriority(751)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalToConstant: 24),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            mainLabel.widthAnchor.constraint(equalToConstant: 110),
            detailsLabelContraint
        ])
    }
    
    func updateLabels() {
        guard let viewModel = cellViewModel else { return }
        mainLabel.text = viewModel.text?.rawValue
        detailsLabel.text = viewModel.detailText
    }
}
