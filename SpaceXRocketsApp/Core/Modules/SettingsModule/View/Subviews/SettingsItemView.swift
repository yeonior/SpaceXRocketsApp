//
//  SettingsItemView.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 29.04.2022.
//

import UIKit

final class SettingsItemView: UIView {
    
    // MARK: - Properties
    var segmentedControlAction: Callback?

    // MARK: - Subviews
    lazy var titleLabel: UILabel = {
        $0.font = Font.tableViewCellMainLabel.uiFont
        $0.textColor = Color.tableViewCellMainLabel.uiColor
        $0.textAlignment = .left
        $0.clipsToBounds = true
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.8
        return $0
    }(UILabel())
    
    lazy var unitSegmentedControl = UISegmentedControl()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func setup() {
        
        // MARK: - TEMP
        let itemsArray = ["", ""]
        unitSegmentedControl = UISegmentedControl(items: itemsArray)
        unitSegmentedControl.selectedSegmentIndex = 0
        unitSegmentedControl.addTarget(nil, action: #selector(segmentDidChange(_:)), for: .valueChanged)
        
        unitSegmentedControl.backgroundColor = Color.segmentedControlBackground.uiColor
        unitSegmentedControl.selectedSegmentTintColor = Color.segmentedControlSelectedSegmentTintColor.uiColor
        unitSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Color.segmentedControlNormalText.uiColor], for: .normal)
        unitSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Color.segmentedControlSelectedText.uiColor], for: .selected)
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, unitSegmentedControl])
        stackView.axis = .horizontal
        stackView.spacing = SettingsViewSizeConstants.spacingBetweenLabelAndSegmentedControl
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            unitSegmentedControl.widthAnchor.constraint(equalToConstant: SettingsViewSizeConstants.segmentedControlWidth),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                               constant: SettingsViewSizeConstants.leftPadding),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                constant: -SettingsViewSizeConstants.rightPadding),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc
    private func segmentDidChange(_ sender: UISegmentedControl) {
        segmentedControlAction?()
    }
}
