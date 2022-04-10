//
//  MainFirstSectionTableViewCell.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 06.04.2022.
//

import UIKit

class MainInfoSectionTableViewCell: UITableViewCell {
    
    var viewModel: CellIdentifiable? {
        didSet {
            updateLabels()
        }
    }
    
    lazy var mainLabel: UILabel = {
        $0.font = Font.tableViewCellMainLabel.uiFont
        $0.textColor = Color.tableViewCellMainLabel.uiColor
        $0.textAlignment = .left
        $0.clipsToBounds = true
        $0.text = "Первый запуск"
        
        return $0
    }(UILabel())
    
    lazy var detailsLabel: UILabel = {
        $0.font = Font.tableViewCellDetailsLabel.uiFont
        $0.textColor = Color.tableViewCellDetailsLabel.uiColor
        $0.textAlignment = .right
        $0.clipsToBounds = true
        $0.text = "7 февраля 2018"
        
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
    
    private func updateLabels() {
        guard let viewModel = viewModel as? MainInfoSectionCellViewModel else { return }
        mainLabel.text = viewModel.mainTitle
        detailsLabel.text = viewModel.detailsTitle
    }
    
    func setupLabels() {
        
        let stackView = UIStackView(arrangedSubviews: [mainLabel, detailsLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        
        contentView.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalToConstant: 24),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32)
        ])
    }
}
