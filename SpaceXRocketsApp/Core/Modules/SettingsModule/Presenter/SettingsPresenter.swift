//
//  SettingsPresenter.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 25.04.2022.
//

protocol SettingsPresenterProtocol {
    func provideTitle()
    func provideBarButtonTitle()
    func provideLabelTitles()
    func provideSegmentedControlTitles()
    func provideHeightUnitType()
    func updateHeightType(with index: Int)
}

// MARK: - Enums
enum lengthUnitType: String {
    case meters = "m"
    case feet   = "ft"
}

enum massUnitType: String {
    case kilos  = "kg"
    case pounds = "lbs"
}

final class SettingsPresenter: SettingsPresenterProtocol {
    
    // MARK: - Properties
    weak var view: SettingsViewProtocol!
    let dataManager: DataManagerProtocol!
    
    var heightUnit: lengthUnitType {
        get {
            DataManager.shared.getLengthUnit(for: #function)
        } set {
            DataManager.shared.setLengthUnit(for: #function, with: newValue)
        }
    }
    
    // MARK: - Init
    init(view: SettingsViewProtocol, dataManager: DataManagerProtocol) {
        self.view = view
        self.dataManager = dataManager
    }
    
    func provideTitle() {
        view.setTitle(with: "Settings")
    }
    
    func provideBarButtonTitle() {
        view.setBarButtonTitle(with: "Close")
    }
    
    func provideLabelTitles() {
        let array = ["Height", "Diameter", "Mass", "Payload"]
        view.setLabelTitles(with: array)
    }
    
    func provideSegmentedControlTitles() {
        let dict = [[0: "m", 1: "ft"],
                    [0: "m", 1: "ft"],
                    [0: "kg", 1: "lb"],
                    [0: "kg", 1: "lb"]]
        view.setSegmentedControlTitles(with: dict)
    }
    
    func provideHeightUnitType() {
        view.setHeightUnit(with: heightUnit)
    }
    
    func updateHeightType(with index: Int) {
        switch index {
        case 0:
            heightUnit = .meters
        case 1:
            heightUnit = .feet
        default:
            break
        }
    }
}
