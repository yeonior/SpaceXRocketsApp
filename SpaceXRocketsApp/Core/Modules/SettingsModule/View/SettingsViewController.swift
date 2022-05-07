//
//  SettingsViewController.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 25.04.2022.
//

import UIKit

protocol SettingsViewProtocol: AnyObject {
    func setTitle(with title: String)
    func setBarButtonTitle(with title: String)
    func setLabelTitles(with titles: [String])
    func setSegmentedControlTitles(with titles: [[Int: String]])
    func setHeightUnit(with unit: LengthUnit)
    func setDiameterUnit(with unit: LengthUnit)
    func setMassUnit(with unit: MassUnit)
    func setPayloadUnit(with unit: MassUnit)
}

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
    
    // MARK: - Subviews
    lazy var settingsView = SettingsView()
    
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
        setHeightItemAction()
        setDiameterItemAction()
        setMassItemAction()
        setPayloadItemAction()
        presenter.provideHeightUnit()
        presenter.provideDiameterUnit()
        presenter.provideMassUnit()
        presenter.providePayloadUnit()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // updating collection view
        NotificationCenter.default.post(name: ObserverConstants.collectionViewUpdateNotificationName, object: nil)
    }
    
    // MARK: - Private methods
    private func configureUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: nil,
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(closeView))
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Color.navigationBarTitleColor.uiColor]
        view.backgroundColor = Color.settingsBackground.uiColor
        navigationItem.rightBarButtonItem?.tintColor = Color.navigationBarButtonColor.uiColor
        
        settingsView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(settingsView)
        
        NSLayoutConstraint.activate([
            settingsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            settingsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            settingsView.topAnchor.constraint(equalTo: view.topAnchor,
                                              constant: SettingsViewSizeConstants.topPadding),
            settingsView.widthAnchor.constraint(equalTo: view.widthAnchor),
            settingsView.heightAnchor.constraint(equalToConstant: SettingsViewSizeConstants.height)
        ])
    }
    
    @objc
    private func closeView() {
        dismiss(animated: true, completion: nil)
    }
    
    // setting item actions
    private func setHeightItemAction() {
        guard let view = settingsView.stackView.arrangedSubviews[0] as? SettingsItemView else { return }
        view.segmentedControlAction = {
            switch view.unitSegmentedControl.selectedSegmentIndex {
            case let index where index == 0:
                self.presenter.updateHeightUnit(with: index)
            case let index where index == 1:
                self.presenter.updateHeightUnit(with: index)
            default:
                break
            }
        }
    }
    
    private func setDiameterItemAction() {
        guard let view = settingsView.stackView.arrangedSubviews[1] as? SettingsItemView else { return }
        view.segmentedControlAction = {
            switch view.unitSegmentedControl.selectedSegmentIndex {
            case let index where index == 0:
                self.presenter.updateDiameterUnit(with: index)
            case let index where index == 1:
                self.presenter.updateDiameterUnit(with: index)
            default:
                break
            }
        }
    }
    
    private func setMassItemAction() {
        guard let view = settingsView.stackView.arrangedSubviews[2] as? SettingsItemView else { return }
        view.segmentedControlAction = {
            switch view.unitSegmentedControl.selectedSegmentIndex {
            case let index where index == 0:
                self.presenter.updateMassUnit(with: index)
            case let index where index == 1:
                self.presenter.updateMassUnit(with: index)
            default:
                break
            }
        }
    }
    
    private func setPayloadItemAction() {
        guard let view = settingsView.stackView.arrangedSubviews[3] as? SettingsItemView else { return }
        view.segmentedControlAction = {
            switch view.unitSegmentedControl.selectedSegmentIndex {
            case let index where index == 0:
                self.presenter.updatePayloadUnit(with: index)
            case let index where index == 1:
                self.presenter.updatePayloadUnit(with: index)
            default:
                break
            }
        }
    }
}

// MARK: - SettingsViewProtocol
extension SettingsViewController: SettingsViewProtocol {
    
    // setting titles
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
    
    // setting units
    func setHeightUnit(with unitType: LengthUnit) {
        guard let view = settingsView.stackView.arrangedSubviews[0] as? SettingsItemView else { return }
        switch unitType {
        case .meters:
            view.unitSegmentedControl.selectedSegmentIndex = 0
        case .feet:
            view.unitSegmentedControl.selectedSegmentIndex = 1
        }
    }
    
    func setDiameterUnit(with unitType: LengthUnit) {
        guard let view = settingsView.stackView.arrangedSubviews[1] as? SettingsItemView else { return }
        switch unitType {
        case .meters:
            view.unitSegmentedControl.selectedSegmentIndex = 0
        case .feet:
            view.unitSegmentedControl.selectedSegmentIndex = 1
        }
    }
    
    func setMassUnit(with unitType: MassUnit) {
        guard let view = settingsView.stackView.arrangedSubviews[2] as? SettingsItemView else { return }
        switch unitType {
        case .kilos:
            view.unitSegmentedControl.selectedSegmentIndex = 0
        case .pounds:
            view.unitSegmentedControl.selectedSegmentIndex = 1
        }
    }
    
    func setPayloadUnit(with unitType: MassUnit) {
        guard let view = settingsView.stackView.arrangedSubviews[3] as? SettingsItemView else { return }
        switch unitType {
        case .kilos:
            view.unitSegmentedControl.selectedSegmentIndex = 0
        case .pounds:
            view.unitSegmentedControl.selectedSegmentIndex = 1
        }
    }
}
