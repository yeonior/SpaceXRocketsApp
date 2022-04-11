//
//  MainSecondStageSectionViewModel.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 11.04.2022.
//

final class MainSecondStageSectionViewModel: MainSectionViewModelProtocol {
    var sectionName: MainSectionType {
        .secondStage
    }
    
    var cells: [MainCellViewModelProtocol]
    
    init(engines: Int, fuelAmountTons: Double, burnTimeSEC: Int?) {
        let enginesCell = MainCellViewModel(text: .engines, detailText: String(engines))
        let fuelAmountCell = MainCellViewModel(text: .fuelAmountTons, detailText: String(fuelAmountTons), unit: "ton")
        var cells = [enginesCell, fuelAmountCell]
        if let burnTimeSEC = burnTimeSEC {
            let burnTimeCell = MainCellViewModel(text: .burnTimeSEC, detailText: String(burnTimeSEC))
            cells.append(burnTimeCell)
        }
        self.cells = cells
    }
}
