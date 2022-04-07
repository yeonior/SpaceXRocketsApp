//
//  MainPageModel.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 08.04.2022.
//

struct MainPageModel {
    let backgroundImages: [String]
    let name: String
    let firstFlight: String
    let costPerLaunch: Int
    let country: String
    
    init(rocket: RocketModel) {
        backgroundImages = rocket.flickrImages
        name = rocket.name
        firstFlight = rocket.firstFlight
        costPerLaunch = rocket.costPerLaunch
        country = rocket.country
    }
}
