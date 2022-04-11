//
//  MainFirstStageViewModelItem.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 11.04.2022.
//

protocol MainStageViewModelItemProtocol {
    var engines: Int { get }
    var fuelAmountTons: Double { get }
    var burnTimeSEC: Int? { get }
}

class MainFirstStageViewModelItem: MainViewModelItem, MainStageViewModelItemProtocol {
    
    var sectionType: MainViewModelSectionType {
        .firstStage
    }
    
    var engines: Int
    var fuelAmountTons: Double
    var burnTimeSEC: Int?
    
    init(engines: Int, fuelAmountTons: Double, burnTimeSEC: Int?) {
        self.engines = engines
        self.fuelAmountTons = fuelAmountTons
        self.burnTimeSEC = burnTimeSEC
    }
}
