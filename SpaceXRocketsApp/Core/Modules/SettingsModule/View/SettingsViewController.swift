//
//  SettingsViewController.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 25.04.2022.
//

import UIKit

protocol SettingsViewTitlesProtocol: AnyObject {
    func setTitle(with title: String)
    func setBarButtonTitle(with title: String)
    func setLabelTitles(with titles: [String])
    func setSegmentedControlTitles(with titles: [[Int: String]])
}

protocol SettingsViewUnitsProtocol: AnyObject {
    func setHeightUnit(with unit: LengthUnit)
    func setDiameterUnit(with unit: LengthUnit)
    func setMassUnit(with unit: MassUnit)
    func setPayloadUnit(with unit: MassUnit)
}

typealias SettingsViewProtocol = SettingsViewTitlesProtocol & SettingsViewUnitsProtocol

struct SettingsViewSizeConstants {
    static let topPadding: CGFloat = 120
    static let leftPadding: CGFloat = 32
    static let rightPadding: CGFloat = 16
    static let spacingItems: CGFloat = 24.0
    static let spacingBetweenLabelAndSegmentedControl: CGFloat = 28.0
    static let segmentedControlWidth: CGFloat = 115
    static let height: CGFloat = 216
}

final class SettingsViewController: UIViewController {
    
    private enum Unit: Int {
        case height     = 0
        case diameter   = 1
        case mass       = 2
        case payload    = 3
    }
    
    // MARK: - Subviews
    private let settingsView = SettingsView()
    
    // MARK: - Properties
    var presenter: SettingsPresenter!
    var router: Routing!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        presenter.provideTitle()
        presenter.provideBarButtonTitle()
        presenter.provideLabelTitles()
        presenter.provideSegmentedControlTitles()
        setSegmentedControlActions()
        presenter.provideHeightUnit()
        presenter.provideDiameterUnit()
        presenter.provideMassUnit()
        presenter.providePayloadUnit()
    }
    
    // MARK: - Private methods
    private func configureUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: nil,
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(closeView))
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Colors.navigationBarTitleColor.uiColor]
        view.backgroundColor = Colors.settingsBackground.uiColor
        navigationItem.rightBarButtonItem?.tintColor = Colors.navigationBarButtonColor.uiColor
        
        settingsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(settingsView)
        
        applyConstraints()
    }
    
    private func applyConstraints() {
        
        let settingsViewConstraints = [
            settingsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            settingsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            settingsView.topAnchor.constraint(equalTo: view.topAnchor,
                                              constant: SettingsViewSizeConstants.topPadding),
            settingsView.widthAnchor.constraint(equalTo: view.widthAnchor),
            settingsView.heightAnchor.constraint(equalToConstant: SettingsViewSizeConstants.height)
        ]
        
        NSLayoutConstraint.activate(settingsViewConstraints)
    }
    
    @objc
    private func closeView() {
        dismiss(animated: true, completion: nil)
    }
    
    private func setSegmentedControlActions() {
        
        func setAction(index: Int, view: UIView, action: @escaping (Int) -> ()) {
            guard let view = view as? SettingsItemView else { return }
            view.segmentedControlAction = { [unowned view, unowned self] in
                switch view.unitSegmentedControl.selectedSegmentIndex {
                case let i where i == 0: action(i)
                case let i where i == 1: action(i)
                default: break
                }
                self.updateCollectionView()
            }
        }
        
        for (index, view) in settingsView.stackView.arrangedSubviews.enumerated() {
            setAction(index: index, view: view) { [unowned self] i in
                switch index {
                case 0: presenter.updateHeightUnit(with: i)
                case 1: presenter.updateDiameterUnit(with: i)
                case 2: presenter.updateMassUnit(with: i)
                case 3: presenter.updatePayloadUnit(with: i)
                default: break
                }
            }
        }
    }
    
    private func updateCollectionView() {
        NotificationCenter.default.post(name: ObserverConstants.collectionViewUpdateNotificationName, object: nil)
    }
}

// MARK: - SettingsViewProtocol
extension SettingsViewController: SettingsViewTitlesProtocol {
    func setTitle(with title: String) {
        self.title = title
    }
    
    func setBarButtonTitle(with title: String) {
        navigationItem.rightBarButtonItem?.title = title
    }
    
    func setLabelTitles(with titles: [String]) {
        for (index, view) in settingsView.stackView.arrangedSubviews.enumerated() {
            guard let view = view as? SettingsItemView else { return }
            view.titleLabel.text = titles[index]
        }
    }
    
    func setSegmentedControlTitles(with titles: [[Int: String]]) {
        for (index, view) in settingsView.stackView.arrangedSubviews.enumerated() {
            guard let view = view as? SettingsItemView else { return }
            view.unitSegmentedControl.setTitle((titles[index])[0], forSegmentAt: 0)
            view.unitSegmentedControl.setTitle((titles[index])[1], forSegmentAt: 1)
        }
    }
}

// MARK: - SettingsViewUnitsProtocol
extension SettingsViewController: SettingsViewUnitsProtocol {
    func setHeightUnit(with unitType: LengthUnit) {
        guard let view = settingsView.stackView.arrangedSubviews[Unit.height.rawValue] as? SettingsItemView else { return }
        switch unitType {
        case .feet:
            view.unitSegmentedControl.selectedSegmentIndex = 0
        case .meters:
            view.unitSegmentedControl.selectedSegmentIndex = 1
        }
    }
    
    func setDiameterUnit(with unitType: LengthUnit) {
        guard let view = settingsView.stackView.arrangedSubviews[Unit.diameter.rawValue] as? SettingsItemView else { return }
        switch unitType {
        case .feet:
            view.unitSegmentedControl.selectedSegmentIndex = 0
        case .meters:
            view.unitSegmentedControl.selectedSegmentIndex = 1
        }
    }
    
    func setMassUnit(with unitType: MassUnit) {
        guard let view = settingsView.stackView.arrangedSubviews[Unit.mass.rawValue] as? SettingsItemView else { return }
        switch unitType {
        case .pounds:
            view.unitSegmentedControl.selectedSegmentIndex = 0
        case .kilos:
            view.unitSegmentedControl.selectedSegmentIndex = 1
        }
    }
    
    func setPayloadUnit(with unitType: MassUnit) {
        guard let view = settingsView.stackView.arrangedSubviews[Unit.payload.rawValue] as? SettingsItemView else { return }
        switch unitType {
        case .pounds:
            view.unitSegmentedControl.selectedSegmentIndex = 0
        case .kilos:
            view.unitSegmentedControl.selectedSegmentIndex = 1
        }
    }
}
