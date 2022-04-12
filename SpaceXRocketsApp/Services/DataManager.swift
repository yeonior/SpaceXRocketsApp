//
//  DataManager.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 10.04.2022.
//

import Foundation

protocol DataManagerProtocol {
    func setRockets(rockets: [RocketModel])
    func getRockets() -> [RocketModel]
    func getData(from stringURL: String) -> Data
}

final class DataManager: DataManagerProtocol {
    static let shared = DataManager()
    var rockets: [RocketModel]?
    
    func setRockets(rockets: [RocketModel]) {
        self.rockets = rockets
    }
    
    func getRockets() -> [RocketModel] {
        guard let rockets = rockets else {
            return []
        }
        return rockets
    }
    
    func getData(from stringURL: String) -> Data {
        guard let url = URL(string: stringURL), let data = try? Data(contentsOf: url) else { return Data()}
        
        return data
    }
}
