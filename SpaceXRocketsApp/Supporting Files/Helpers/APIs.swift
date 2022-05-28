//
//  API.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 08.04.2022.
//

import Foundation

enum APIs {
    case rockets
    case launches
    
    var url: URL {
        switch self {
        case .rockets:
            return URL(string: "https://api.spacexdata.com/v4/rockets")!
        case .launches:
            return URL(string: "https://api.spacexdata.com/v4/launches")!
        }
    }
}
