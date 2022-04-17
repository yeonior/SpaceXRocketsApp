//
//  LaunchModel.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 12.04.2022.
//

import Foundation

struct LaunchModel: Decodable {
    let rocketId, name, dateLocal: String
    let success: Bool?
    
    enum CodingKeys: String, CodingKey {
        case rocketId = "rocket"
        case name
        case dateLocal = "date_local"
        case success
    }
}
