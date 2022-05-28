//
//  DataManager.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 10.04.2022.
//

import Foundation

protocol DataManagerReadable: AnyObject {
    func getAppFirstRunStatus() -> Bool
    func getRockets() -> [RocketModel]
    func getLaunches() -> [LaunchModel]
    func getLengthUnit(for name: String) -> LengthUnit
    func getMassUnit(for name: String) -> MassUnit
}

protocol DataManagerWritable: AnyObject {
    func setAppFirstRunStatus()
    func setRockets(_ rockets: [RocketModel])
    func setLaunches(_ launches: [LaunchModel])
    func setDefaultUnits()
    func setLengthUnit(for name: String, with unit: LengthUnit)
    func setMassUnit(for name: String, with unit: MassUnit)
}

protocol DataManagerFetchesProtocol: AnyObject {
    func fetchData(from stringURL: String) -> Data
}

typealias DataManagerProtocol = DataManagerReadable & DataManagerWritable & DataManagerFetchesProtocol

final class DataManager {
    
    // MARK: - Properties
    static let shared = DataManager()
    private let userDefaults = UserDefaults.standard
    private let concurrentQueue = DispatchQueue(label: "concurrent-queue", attributes: .concurrent)
    private let appLaunchKey = "launchedBefore"
    private var rockets: [RocketModel]?
    private var launches: [LaunchModel]?
    
    // MARK: - Init
    private init() {}
}


// MARK: - DataManagerReadable
extension DataManager: DataManagerReadable {
    func getAppFirstRunStatus() -> Bool {
        userDefaults.bool(forKey: appLaunchKey)
    }
    
    func getRockets() -> [RocketModel] {
        var safeRockets = [RocketModel]()
        concurrentQueue.sync { [weak self] in
            safeRockets = self?.rockets ?? []
        }
        
        return safeRockets
    }
    
    func getLaunches() -> [LaunchModel] {
        var safeLaunches = [LaunchModel]()
        concurrentQueue.sync { [weak self] in
            safeLaunches = self?.launches ?? []
        }
        
        return safeLaunches
    }
    
    func getLengthUnit(for name: String) -> LengthUnit {
        guard let rawValue = userDefaults.string(forKey: name) else { return .feet}
        let lengthUnitType = LengthUnit(rawValue: rawValue)!
        
        return lengthUnitType
    }
    
    func getMassUnit(for name: String) -> MassUnit {
        guard let rawValue = userDefaults.string(forKey: name) else { return .pounds}
        let massUnitType = MassUnit(rawValue: rawValue)!
        
        return massUnitType
    }
}

// MARK: - DataManagerWritable
extension DataManager: DataManagerWritable {
    func setAppFirstRunStatus() {
        userDefaults.set(true, forKey: appLaunchKey)
    }
    
    func setRockets(_ rockets: [RocketModel]) {
        self.rockets = rockets
    }
    
    func setLaunches(_ launches: [LaunchModel]) {
        self.launches = launches
    }
    
    func setDefaultUnits() {
        setLengthUnit(for: Parameter.height.rawValue, with: .feet)
        setLengthUnit(for: Parameter.diameter.rawValue, with: .feet)
        setMassUnit(for: Parameter.mass.rawValue, with: .pounds)
        setMassUnit(for: Parameter.payload.rawValue, with: .pounds)
    }
    
    func setLengthUnit(for name: String, with unit: LengthUnit) {
        userDefaults.set(unit.rawValue, forKey: name)
    }
    
    func setMassUnit(for name: String, with unit: MassUnit) {
        userDefaults.set(unit.rawValue, forKey: name)
    }
}

// MARK: - DataManagerFetchesProtocol
extension DataManager: DataManagerFetchesProtocol {
    func fetchData(from stringURL: String) -> Data {
        guard let url = URL(string: stringURL),
              let data = try? Data(contentsOf: url) else { return Data() }
        
        return data
    }
}
