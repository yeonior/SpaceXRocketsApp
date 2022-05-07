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
    func provideHeightUnit()
    func provideDiameterUnit()
    func provideMassUnit()
    func providePayloadUnit()
    func updateHeightUnit(with index: Int)
    func updateDiameterUnit(with index: Int)
    func updateMassUnit(with index: Int)
    func updatePayloadUnit(with index: Int)
}

// MARK: - Enums
enum Parameter: String {
    case height     = "Height"
    case diameter   = "Diameter"
    case mass       = "Mass"
    case payload    = "Payload"
    case unknown    = "N/A"
}

enum LengthUnit: String {
    case meters = "m"
    case feet   = "ft"
}

enum MassUnit: String {
    case kilos  = "kg"
    case pounds = "lb"
}

final class SettingsPresenter: SettingsPresenterProtocol {
    
    // MARK: - Properties
    weak var view: SettingsViewProtocol!
    let dataManager: DataManagerProtocol!
    
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
        let dict = [[0: LengthUnit.meters.rawValue, 1: LengthUnit.feet.rawValue],
                    [0: LengthUnit.meters.rawValue, 1: LengthUnit.feet.rawValue],
                    [0: MassUnit.kilos.rawValue,    1: MassUnit.pounds.rawValue],
                    [0: MassUnit.kilos.rawValue,    1: MassUnit.pounds.rawValue]]
        view.setSegmentedControlTitles(with: dict)
    }
    
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
        case 0:
            heightUnit = .meters
        case 1:
            heightUnit = .feet
        default:
            break
        }
    }
    
    func updateDiameterUnit(with index: Int) {
        switch index {
        case 0:
            diameterUnit = .meters
        case 1:
            diameterUnit = .feet
        default:
            break
        }
    }
    
    func updateMassUnit(with index: Int) {
        switch index {
        case 0:
            massUnit = .kilos
        case 1:
            massUnit = .pounds
        default:
            break
        }
    }
    
    func updatePayloadUnit(with index: Int) {
        switch index {
        case 0:
            payloadUnit = .kilos
        case 1:
            payloadUnit = .pounds
        default:
            break
        }
    }
}
