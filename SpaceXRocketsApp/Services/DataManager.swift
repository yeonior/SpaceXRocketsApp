//
//  DataManager.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 10.04.2022.
//

import Foundation

protocol DataManagerProtocol {
    func getData(from stringURL: String) -> Data
    func setRockets(_ rockets: [RocketModel])
    func getRockets() -> [RocketModel]
    func setLaunches(_ launches: [LaunchModel])
    func getLaunches() -> [LaunchModel]
}

final class DataManager: DataManagerProtocol {
    
    // MARK: - Properties
    static let shared = DataManager()
    private var rockets: [RocketModel]?
    private var launches: [LaunchModel]?
    
    // MARK: - Init
    private init() {}
    
    // MARK: - Methods
    func getData(from stringURL: String) -> Data {
        guard let url = URL(string: stringURL),
              let data = try? Data(contentsOf: url) else { return Data() }
        
        return data
    }
    
    func setRockets(_ rockets: [RocketModel]) {
        self.rockets = rockets
    }
    
    func getRockets() -> [RocketModel] {
        guard let rockets = rockets else { return [] }
        
        return rockets
    }
    
    func setLaunches(_ launches: [LaunchModel]) {
        self.launches = launches
    }
    
    func getLaunches() -> [LaunchModel] {
        guard let launches = launches else { return [] }
        
        return launches
    }
}
