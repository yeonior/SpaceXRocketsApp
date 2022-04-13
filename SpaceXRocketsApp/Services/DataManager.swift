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
    func setLaunches(launches: [LaunchModel])
    func getLaunches() -> [LaunchModel]
}

final class DataManager: DataManagerProtocol {
    static let shared = DataManager()
    var rockets: [RocketModel]?
    var launches: [LaunchModel]?
    
    func setRockets(rockets: [RocketModel]) {
        self.rockets = rockets
    }
    
    func getRockets() -> [RocketModel] {
        guard let rockets = rockets else {
            return []
        }
        return rockets
    }
    
//    func getRocket(by number: Int) -> RocketModel {
//        let index = number - 1
//        if let rocket = rockets?[index] {
//            return rocket
//        }
//        return RocketModel
//    }
    
    func getData(from stringURL: String) -> Data {
        guard let url = URL(string: stringURL), let data = try? Data(contentsOf: url) else { return Data()}
        
        return data
    }
    
    func setLaunches(launches: [LaunchModel]) {
        self.launches = launches
    }
    
    func getLaunches() -> [LaunchModel] {
        guard let launches = launches else {
            return []
        }
        return launches
    }
}
