//
//  MainCellViewModel.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 11.04.2022.
//

enum MainCellTextType: String {
    case company        = "Компания"
    case country        = "Страна"
    case firstFlight    = "Первый полет"
    case engines        = "Количество двигателей"
    case fuelAmountTons = "Количество топлива"
    case burnTimeSEC    = "Время сгорания"

}

enum MainSectionType: String {
    case info
    case firstStage     = "ПЕРВАЯ СТУПЕНЬ"
    case secondStage    = "ВТОРАЯ СТУПЕНЬ"
}

protocol MainCellViewModelProtocol {
    var text: MainCellTextType { get }
    var detailText: String { get }
    var unit: String { get }
}

protocol MainSectionViewModelProtocol {
    var sectionName: MainSectionType { get }
    var cells: [MainCellViewModelProtocol] { get }
}

final class MainCellViewModel: MainCellViewModelProtocol {
    
    var text: MainCellTextType
    var detailText: String
    var unit: String
    
    init(text: MainCellTextType, detailText: String, unit: String = "") {
        self.text = text
        self.detailText = detailText
        self.unit = unit
    }
}
