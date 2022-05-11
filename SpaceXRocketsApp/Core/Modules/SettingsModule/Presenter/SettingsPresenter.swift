//
//  SettingsPresenter.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 25.04.2022.
//

// MARK: - Protocols
protocol SettingsPresenterTitlesProtocol {
    func provideTitle()
    func provideBarButtonTitle()
    func provideLabelTitles()
    func provideSegmentedControlTitles()
}

protocol SettingsPresenterUnitsProtocol {
    func provideHeightUnit()
    func provideDiameterUnit()
    func provideMassUnit()
    func providePayloadUnit()
    func updateHeightUnit(with index: Int)
    func updateDiameterUnit(with index: Int)
    func updateMassUnit(with index: Int)
    func updatePayloadUnit(with index: Int)
}

typealias SettingsPresenterProtocol = SettingsPresenterTitlesProtocol & SettingsPresenterUnitsProtocol

// MARK: - Enums
enum Parameter: String {
    case height     = "Height"
    case diameter   = "Diameter"
    case mass       = "Mass"
    case payload    = "Payload"
    case unknown    = "N/A"
}

enum LengthUnit: String {
    case feet   = "ft"
    case meters = "m"
}

enum MassUnit: String {
    case pounds = "lb"
    case kilos  = "kg"
}

final class SettingsPresenter {
    
    // MARK: - Properties
    weak var view: SettingsViewProtocol!
    let dataManager: DataManagerProtocol!
    
    // units
    var heightUnit: LengthUnit {
        get {
            DataManager.shared.getLengthUnit(for: Parameter.height.rawValue)
        } set {
            DataManager.shared.setLengthUnit(for: Parameter.height.rawValue, with: newValue)
        }
    }
    
    var diameterUnit: LengthUnit {
        get {
            DataManager.shared.getLengthUnit(for: Parameter.diameter.rawValue)
        } set {
            DataManager.shared.setLengthUnit(for: Parameter.diameter.rawValue, with: newValue)
        }
    }
    
    var massUnit: MassUnit {
        get {
            DataManager.shared.getMassUnit(for: Parameter.mass.rawValue)
        } set {
            DataManager.shared.setMassUnit(for: Parameter.mass.rawValue, with: newValue)
        }
    }
    
    var payloadUnit: MassUnit {
        get {
            DataManager.shared.getMassUnit(for: Parameter.payload.rawValue)
        } set {
            DataManager.shared.setMassUnit(for: Parameter.payload.rawValue, with: newValue)
        }
    }
    
    // MARK: - Init
    init(view: SettingsViewProtocol, dataManager: DataManagerProtocol) {
        self.view = view
        self.dataManager = dataManager
    }
}

// MARK: - SettingsPresenterTitlesProtocol
extension SettingsPresenter: SettingsPresenterTitlesProtocol {
    // providing titles
    func provideTitle() {
        view.setTitle(with: "Settings")
    }
    
    func provideBarButtonTitle() {
        view.setBarButtonTitle(with: "Close")
    }
    
    func provideLabelTitles() {
        let array = [Parameter.height.rawValue,
                     Parameter.diameter.rawValue,
                     Parameter.mass.rawValue,
                     Parameter.payload.rawValue]
        view.setLabelTitles(with: array)
    }
    
    func provideSegmentedControlTitles() {
        let dict = [[0: LengthUnit.feet.rawValue, 1: LengthUnit.meters.rawValue],
                    [0: LengthUnit.feet.rawValue, 1: LengthUnit.meters.rawValue],
                    [0: MassUnit.pounds.rawValue, 1: MassUnit.kilos.rawValue],
                    [0: MassUnit.pounds.rawValue, 1: MassUnit.kilos.rawValue]]
        view.setSegmentedControlTitles(with: dict)
    }
}

// MARK: - SettingsPresenterUnitsProtocol
extension SettingsPresenter: SettingsPresenterUnitsProtocol {
    // providing units
    func provideHeightUnit() {
        view.setHeightUnit(with: heightUnit)
    }
    
    func provideDiameterUnit() {
        view.setDiameterUnit(with: diameterUnit)
    }
    
    func provideMassUnit() {
        view.setMassUnit(with: massUnit)
    }
    
    func providePayloadUnit() {
        view.setPayloadUnit(with: payloadUnit)
    }
    
    // updating units
    func updateHeightUnit(with index: Int) {
        switch index {
        case 0: heightUnit = .feet
        case 1: heightUnit = .meters
        default: break
        }
    }
    
    func updateDiameterUnit(with index: Int) {
        switch index {
        case 0: diameterUnit = .feet
        case 1: diameterUnit = .meters
        default: break
        }
    }
    
    func updateMassUnit(with index: Int) {
        switch index {
        case 0: massUnit = .pounds
        case 1: massUnit = .kilos
        default: break
        }
    }
    
    func updatePayloadUnit(with index: Int) {
        switch index {
        case 0: payloadUnit = .pounds
        case 1: payloadUnit = .kilos
        default: break
        }
    }
}
