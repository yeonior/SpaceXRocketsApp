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
    let titleLabel: UILabel = {
        $0.font = Fonts.tableViewCellMainLabel.uiFont
        $0.textColor = Colors.tableViewCellMainLabel.uiColor
        $0.textAlignment = .left
        $0.clipsToBounds = true
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.8
        return $0
    }(UILabel())
    
    lazy var unitSegmentedControl: UISegmentedControl = {
        let itemsArray = ["", ""]
        let segmentedControl = UISegmentedControl(items: itemsArray)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(nil, action: #selector(segmentDidChange(_:)), for: .valueChanged)
        segmentedControl.backgroundColor = Colors.segmentedControlBackground.uiColor
        segmentedControl.selectedSegmentTintColor = Colors.segmentedControlSelectedSegmentTintColor.uiColor
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Colors.segmentedControlNormalText.uiColor], for: .normal)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Colors.segmentedControlSelectedText.uiColor], for: .selected)
        return segmentedControl
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, unitSegmentedControl])
        stackView.axis = .horizontal
        stackView.spacing = SettingsViewSizeConstants.spacingBetweenLabelAndSegmentedControl
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func configureViews() {
        
        addSubview(stackView)
        
        applyConstraints()
    }
    
    private func applyConstraints() {
        
        let unitSegmentedControlConstraints = [
            unitSegmentedControl.widthAnchor.constraint(equalToConstant: SettingsViewSizeConstants.segmentedControlWidth)
        ]
        
        let stackViewConstraints = [
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                               constant: SettingsViewSizeConstants.leftPadding),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                constant: -SettingsViewSizeConstants.rightPadding),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(unitSegmentedControlConstraints)
        NSLayoutConstraint.activate(stackViewConstraints)
    }
    
    @objc
    private func segmentDidChange(_ sender: UISegmentedControl) {
        segmentedControlAction?()
    }
}
