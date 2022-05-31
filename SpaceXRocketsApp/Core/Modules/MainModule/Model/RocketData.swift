//
//  RocketData.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 08.04.2022.
//

// MARK: - RocketData
struct RocketData {
    let id: String
    let flickrImages: [String]
    let name: String
    let height, diameter, mass, payloadWeight: Parameter
    let firstFlight, country: String
    let costPerLaunch: Int
    let firstStage, secondStage: Stage
    
    // MARK: - Parameter
    struct Parameter {
        let value: String
        let unit: String
    }
    
    // MARK: - Stage
    struct Stage {
        let engines: Int
        let fuelAmountTons: Double
        let burnTimeSec: Int?
    }
}
