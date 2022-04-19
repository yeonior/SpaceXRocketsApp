//
//  MainStageSectionViewModel.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 11.04.2022.
//

private enum UnitType: String {
    case ton = "ton"
    case sec = "sec"
}

final class MainStageSectionViewModel: MainSectionViewModelProtocol {
    
    // MARK: - Properties
    var name: MainSectionType
    var cells: [MainTableViewCellViewModelProtocol]
    
    // MARK: - Init
    init(sectionName: MainSectionType,
         engines: Int,
         fuelAmountTons: Double,
         burnTimeSEC: Int?) {
        
        let enginesCell = MainTableViewCellViewModel(text: .engines,
                                            detailText: String(engines))
        let fuelAmountCell = MainTableViewCellViewModel(text: .fuelAmountTons,
                                               detailText: String(fuelAmountTons),
                                               unit: UnitType.ton.rawValue)
        var cells = [enginesCell, fuelAmountCell]
        
        if let burnTimeSEC = burnTimeSEC {
            let burnTimeCell = MainTableViewCellViewModel(text: .burnTimeSEC,
                                                 detailText: String(burnTimeSEC),
                                                 unit: UnitType.sec.rawValue)
            cells.append(burnTimeCell)
        }
        
        self.name = sectionName
        self.cells = cells
    }
}
