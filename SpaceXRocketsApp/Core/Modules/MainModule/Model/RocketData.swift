//
//  RocketData.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 08.04.2022.
//

struct RocketData {
    let id: String
    let flickrImages: [String]
    let name: String
    let height, diameter: Diameter
    let mass: Mass
    let payloadWeights: [PayloadWeight]
    let firstFlight, country: String
    let costPerLaunch: Int
    let firstStage, secondStage: Stage
    
    struct Stage {
        let engines: Int
        let fuelAmountTons: Double
        let burnTimeSEC: Int?
    }
}
