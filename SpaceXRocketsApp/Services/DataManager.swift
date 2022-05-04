//
//  DataManager.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 10.04.2022.
//

import Foundation

protocol DataManagerProtocol: AnyObject {
    func getFirstLaunchStatus() -> Bool
    func changeFirstLauchStatus()
    func getData(from stringURL: String) -> Data
    func setRockets(_ rockets: [RocketModel])
    func getRockets() -> [RocketModel]
    func setLaunches(_ launches: [LaunchModel])
    func getLaunches() -> [LaunchModel]
    func setDefaultUnits()
    func setLengthUnit(for name: String, with unit: lengthUnitType)
    func getLengthUnit(for name: String) -> lengthUnitType
    func setMassUnit(for name: String, with unit: massUnitType)
    func getMassUnit(for name: String) -> massUnitType
}

final class DataManager: DataManagerProtocol {
    
    // MARK: - Properties
    static let shared = DataManager()
    private let userDefaults = UserDefaults.standard
    private var rockets: [RocketModel]?
    private var launches: [LaunchModel]?
    
    // MARK: - Init
    private init() {}
    
    // MARK: - Methods
    func getFirstLaunchStatus() -> Bool {
        userDefaults.bool(forKey: "launchedBefore")
    }
    
    func changeFirstLauchStatus() {
        userDefaults.set(true, forKey: "launchedBefore")
    }
    
    func getData(from stringURL: String) -> Data {
        guard let url = URL(string: stringURL),
              let data = try? Data(contentsOf: url) else { return Data() }
        
        return data
    }
    
    func setRockets(_ rockets: [RocketModel]) {
        self.rockets = rockets
    }
    
    func getRockets() -> [RocketModel] {
        var safeRockets = [RocketModel]()
        safeRockets = rockets ?? []
        
        return safeRockets
    }
    
    func setLaunches(_ launches: [LaunchModel]) {
        self.launches = launches
    }
    
    func getLaunches() -> [LaunchModel] {
        var safeLaunches = [LaunchModel]()
        safeLaunches = launches ?? []
        
        return safeLaunches
    }
    
    func setDefaultUnits() {
        setLengthUnit(for: "heightUnit", with: .feet)
        setLengthUnit(for: "diameterUnit", with: .feet)
        setMassUnit(for: "massUnit", with: .pounds)
    }
    
    func setLengthUnit(for name: String, with unit: lengthUnitType) {
        userDefaults.set(unit.rawValue, forKey: name)
    }
    
    func getLengthUnit(for name: String) -> lengthUnitType {
        let rawValue = userDefaults.string(forKey: name)!
        let lengthUnitType = lengthUnitType(rawValue: rawValue)!
        return lengthUnitType
    }
    
    func setMassUnit(for name: String, with unit: massUnitType) {
        userDefaults.set(unit.rawValue, forKey: name)
    }
    
    func getMassUnit(for name: String) -> massUnitType {
        let rawValue = userDefaults.string(forKey: name)!
        let massUnitType = massUnitType(rawValue: rawValue)!
        return massUnitType
    }
}
