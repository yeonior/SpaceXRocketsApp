//
//  DataManager.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 10.04.2022.
//

import Foundation

protocol DataManagerProtocol {
    func setRockets(rockets: [Rocket])
    func getRockets() -> [Rocket]
    func getData(from stringURL: String) -> Data
}

final class DataManager: DataManagerProtocol {
    static let shared = DataManager()
    var rockets: [Rocket]?
    
    func setRockets(rockets: [Rocket]) {
        self.rockets = rockets
    }
    
    func getRockets() -> [Rocket] {
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
