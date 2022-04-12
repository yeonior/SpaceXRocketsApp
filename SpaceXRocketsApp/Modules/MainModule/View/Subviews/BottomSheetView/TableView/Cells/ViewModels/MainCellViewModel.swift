//
//  MainCellViewModel.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 11.04.2022.
//

enum MainTextCellTextType: String {
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
