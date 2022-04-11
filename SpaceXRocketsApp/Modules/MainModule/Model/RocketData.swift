//
//  RocketData.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 08.04.2022.
//

struct RocketData {
    let firstStage: FirstStage
    let secondStage: SecondStage
    let firstFlight: String
    let country: String
    let company: String
    let flickrImages: [String]
    
    struct FirstStage {
        let engines: Int
        let fuelAmountTons: Double
        let burnTimeSEC: Int?
    }
    
    struct SecondStage {
        let engines: Int
        let fuelAmountTons: Double
        let burnTimeSEC: Int?
    }
}
