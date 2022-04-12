//
//  RocketData.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 08.04.2022.
//

struct RocketData {
    let flickrImages: [String]
    let name: String
    let firstFlight: String
    let country: String
    let costPerLaunch: Int
    let firstStage: Stage
    let secondStage: Stage
    
    struct Stage {
        let engines: Int
        let fuelAmountTons: Double
        let burnTimeSEC: Int?
    }
}
