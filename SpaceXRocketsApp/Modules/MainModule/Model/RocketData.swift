//
//  RocketData.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 08.04.2022.
//

struct RocketData {
    let name: String
    let country: String
    let firstFlight: String
    let costPerLaunch: Int

    init(rocket: Rocket) {
        name = rocket.name
        country = rocket.country
        firstFlight = rocket.firstFlight
        costPerLaunch = rocket.costPerLaunch
    }
    
//    let rows: [Row]
//
//    struct Row {
//        let title: String
//        let item: String
//    }
//
//    init(rocket: Rocket) {
//        for i in rocket {
//
//        }
//    }
}
