//
//  MainInfoSectionViewModel.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 11.04.2022.
//

import Foundation

final class MainInfoSectionViewModel: MainSectionViewModelProtocol {
    
    var name: MainSectionType {
        .info
    }
    
    var cells: [MainCellViewModelProtocol]
    
    init(firstFlight: String, country: String, costPerLaunch: Int) {
        
        let firstLaunchCell = MainCellViewModel(text: .firstFlight,
                                                detailText: TextFormatter.convertDateFormat(
                                                    date: firstFlight,
                                                    from: .yyyyMMdd,
                                                    to: .MMddyyyy))
        let countryCell = MainCellViewModel(text: .country,
                                            detailText: country)
        let costPerLaunch = MainCellViewModel(text: .costPerLaunch,
                                              detailText: TextFormatter.roundNumberWithUnit(costPerLaunch))
        
        let cells = [firstLaunchCell, countryCell, costPerLaunch]
        
        self.cells = cells
    }
}
