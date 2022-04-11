//
//  MainViewModelItem.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 11.04.2022.
//

enum MainViewModelSectionType: String {
    case info
    case firstStage = "ПЕРВАЯ СТУПЕНЬ"
    case secondStage = "ВТОРАЯ СТУПЕНЬ"
}

//enum MainViewModelItemType: String {
//    case company = "Компания"
//    case country = "Страна"
//    case firstFlight = "Первый полет"
//    case engines = "Количество двигателей"
//    case fuelAmountTons = "Количество топлива"
//    case burnTimeSEC = "Время сгорания"
//}

protocol MainViewModelItem {
    var sectionType: MainViewModelSectionType { get }
//    var itemType: MainViewModelItemType { get }
    var rows: Int { get }
}

extension MainViewModelItem {
    var rows: Int {
        3
    }
}
