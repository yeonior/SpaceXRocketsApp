//
//  MainShowButtonCell.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 07.04.2022.
//

import UIKit

private struct MainShowButtonSizeConstants {
    static let cornerRadius: CGFloat = 14.0
}

final class MainShowButtonCell: UITableViewCell {
    
    // MARK: - Properties
    static let identifier = "buttonCell"
    
    var buttonAction: Callback?
    
    // MARK: - Subviews
    let showButton: UIButton = {
        $0.layer.cornerRadius = MainShowButtonSizeConstants.cornerRadius
        $0.backgroundColor = Colors.showButton.uiColor
        $0.titleLabel?.textColor = Colors.showButtonText.uiColor
        $0.titleLabel?.font = Fonts.showButton.uiFont
        $0.setTitle("Show the launches", for: .normal)
        return $0
    }(UIButton())
    
    let baseView: UIView = {
        $0.backgroundColor = Colors.tableViewCellBackground.uiColor
        return $0
    }(UIView())
    
    // MARK: - Init
    private override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        baseView.frame = contentView.bounds
    }
    
    // MARK: - Private methods
    private func configureViews() {
        
        showButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        showButton.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(baseView)
        baseView.addSubview(showButton)
        
        applyConstraints()
    }
    
    private func applyConstraints() {
        
        let showButtonConstraints = [
            showButton.topAnchor.constraint(equalTo: baseView.topAnchor),
            showButton.bottomAnchor.constraint(equalTo: baseView.bottomAnchor),
            showButton.leadingAnchor.constraint(equalTo: baseView.leadingAnchor,
                                                constant: Sizes.leftPadding),
            showButton.trailingAnchor.constraint(equalTo: baseView.trailingAnchor,
                                                 constant: -Sizes.rightPadding)
        ]
        
        NSLayoutConstraint.activate(showButtonConstraints)
    }
    
    @objc
    private func didTapButton() {
        buttonAction?()
    }
}
