//
//  MainShowButtonCell.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 07.04.2022.
//

import UIKit

private struct MainShowButtonSizeConstants {
    static let cornerRadius: CGFloat = 14.0
    static let leftPadding: CGFloat = 32.0
    static let rightPadding: CGFloat = 32.0
}

final class MainShowButtonCell: UITableViewCell {
    
    // MARK: - Properties
    static let identifier = "buttonCell"
    
    // MARK: - Subviews
    let showButton: UIButton = {
        $0.layer.cornerRadius = MainShowButtonSizeConstants.cornerRadius
        $0.backgroundColor = Color.showButton.uiColor
        $0.titleLabel?.textColor = Color.showButtonText.uiColor
        $0.titleLabel?.font = Font.showButton.uiFont
        $0.setTitle("Show the launches", for: .normal)
        return $0
    }(UIButton())
    let baseView: UIView = {
        $0.backgroundColor = Color.tableViewCellBackground.uiColor
        return $0
    }(UIView())
    
    // MARK: - Button action
    var buttonTapCallback: (() -> ())?
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func setup() {
        
        showButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        baseView.translatesAutoresizingMaskIntoConstraints = false
        showButton.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(baseView)
        baseView.addSubview(showButton)
        
        NSLayoutConstraint.activate([
            baseView.topAnchor.constraint(equalTo: contentView.topAnchor),
            baseView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            baseView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            baseView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            showButton.topAnchor.constraint(equalTo: baseView.topAnchor),
            showButton.bottomAnchor.constraint(equalTo: baseView.bottomAnchor),
            showButton.leadingAnchor.constraint(equalTo: baseView.leadingAnchor,
                                                constant: MainShowButtonSizeConstants.leftPadding),
            showButton.trailingAnchor.constraint(equalTo: baseView.trailingAnchor,
                                                 constant: -MainShowButtonSizeConstants.rightPadding)
        ])
    }
    
    @objc
    private func didTapButton() {
        buttonTapCallback?()
    }
}
