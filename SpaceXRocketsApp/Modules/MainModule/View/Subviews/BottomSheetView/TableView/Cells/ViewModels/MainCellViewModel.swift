//
//  MainCellViewModel.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 11.04.2022.
//

enum MainTextCellTextType: String {
    case firstFlight    = "First flight"
    case country        = "Country"
    case costPerLaunch  = "Cost per launch"
    case engines        = "Engines"
    case fuelAmountTons = "Fuel amount"
    case burnTimeSEC    = "Burn time"

}

enum MainSectionType: String {
    case info
    case firstStage     = "FIRST STAGE"
    case secondStage    = "SECOND STAGE"
    case button
}

protocol MainCellViewModelProtocol {
    var text: MainTextCellTextType? { get }
    var detailText: String? { get }
    var unit: String? { get }
}

protocol MainSectionViewModelProtocol {
    var name: MainSectionType { get }
    var cells: [MainCellViewModelProtocol] { get }
}

final class MainCellViewModel: MainCellViewModelProtocol {
    var text: MainTextCellTextType?
    var detailText: String?
    var unit: String?
    
    init() {
        self.text = nil
        self.detailText = nil
        self.unit = nil
    }
    
    init(text: MainTextCellTextType, detailText: String, unit: String? = nil) {
        self.text = text
        self.detailText = detailText
        self.unit = unit
    }
}
