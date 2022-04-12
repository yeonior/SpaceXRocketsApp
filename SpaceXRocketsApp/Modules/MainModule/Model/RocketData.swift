//
//  RocketData.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 08.04.2022.
//

struct RocketData {
    let name: String
    let firstStage: Stage
    let secondStage: Stage
    let firstFlight: String
    let country: String
    let company: String
    let flickrImages: [String]
    
    struct Stage {
        let engines: Int
        let fuelAmountTons: Double
        let burnTimeSEC: Int?
    }
}
