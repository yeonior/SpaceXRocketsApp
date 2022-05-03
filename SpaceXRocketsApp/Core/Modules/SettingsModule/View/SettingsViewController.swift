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
    func setHeightUnit(with unitType: lengthUnitType)
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
        presenter.provideHeightUnitType()
        setHeightUnitAction()
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
            settingsView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            settingsView.widthAnchor.constraint(equalTo: view.widthAnchor),
            settingsView.heightAnchor.constraint(equalToConstant: 216)
        ])
    }
    
    @objc
    private func closeView() {
        dismiss(animated: true, completion: nil)
    }
    
    private func setHeightUnitAction() {
        guard let view = settingsView.stackView.arrangedSubviews.first as? SettingsItemView else { return }
        view.segmentedControlAction = {
            switch view.unitSegmentedControl.selectedSegmentIndex {
            case let index where index == 0:
                self.presenter.updateHeightType(with: index)
            case let index where index == 1:
                self.presenter.updateHeightType(with: index)
            default:
                break
            }
        }
    }
}

// MARK: - SettingsViewProtocol
extension SettingsViewController: SettingsViewProtocol {
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
    
    func setHeightUnit(with unitType: lengthUnitType) {
        guard let view = settingsView.stackView.arrangedSubviews.first as? SettingsItemView else { return }
        switch unitType {
        case .meters:
            view.unitSegmentedControl.selectedSegmentIndex = 0
        case .feet:
            view.unitSegmentedControl.selectedSegmentIndex = 1
        }
    }
}
