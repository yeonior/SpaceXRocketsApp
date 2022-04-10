//
//  MainInfoCellViewModel.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 10.04.2022.
//

import Foundation

protocol CellIdentifiable {
    var cellIdentifier: String { get }
    var cellHeight: Double { get }
}

protocol InfoSectionCellPresentable: CellIdentifiable {
    init(rocketData: RocketData)
}

final class MainInfoSectionCellViewModel: InfoSectionCellPresentable {
    
    let mainTitle: String
    let detailsTitle: String
    
    var cellIdentifier: String {
        "mainInfoCell"
    }
    var cellHeight: Double {
        50
    }
    
    init(rocketData: RocketData) {
        
        mainTitle = "Date"
        detailsTitle = rocketData.firstFlight
    }
}
