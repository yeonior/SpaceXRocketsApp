//
//  MainStageSectionViewModel.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 11.04.2022.
//

final class MainStageSectionViewModel: MainSectionViewModelProtocol {
    
    var name: MainSectionType
    var cells: [MainCellViewModelProtocol]
    
    init(sectionName: MainSectionType,
         engines: Int,
         fuelAmountTons: Double,
         burnTimeSEC: Int?) {
        
        let enginesCell = MainCellViewModel(text: .engines, detailText: String(engines))
        let fuelAmountCell = MainCellViewModel(text: .fuelAmountTons, detailText: String(fuelAmountTons), unit: "ton")
        var cells = [enginesCell, fuelAmountCell]
        if let burnTimeSEC = burnTimeSEC {
            let burnTimeCell = MainCellViewModel(text: .burnTimeSEC, detailText: String(burnTimeSEC), unit: "sec")
            cells.append(burnTimeCell)
        }
        
        self.name = sectionName
        self.cells = cells
    }
}