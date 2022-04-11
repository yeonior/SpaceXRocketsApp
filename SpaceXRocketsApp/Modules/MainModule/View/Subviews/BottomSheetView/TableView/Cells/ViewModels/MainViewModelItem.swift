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

//enum MainViewModelItemType {
//    case company        //= "Компания"
//    case country        //= "Страна"
//    case firstFlight    //= "Первый полет"
//    case engines        //= "Количество двигателей"
//    case fuelAmountTons //= "Количе//ство топлива"
//    case burnTimeSEC    //= "Время сгорания"
//
//    var stringValue: String {
//        switch self {
//        case .company:
//            return "Компания"
//        case .country:
//            return "Страна"
//        case .firstFlight:
//            return "Первый полет"
//        case .engines:
//            return "Количество двигателей"
//        case .fuelAmountTons:
//            return ""
//        case .burnTimeSEC:
//            return "Время сгорания"
//        }
//    }
//}

protocol MainViewModelItem {
    var sectionType: MainViewModelSectionType { get }
//    var itemType: MainViewModelItemType? { get }
    var rows: Int { get }
}

extension MainViewModelItem {
    var rows: Int {
        3
    }
}

//// cell
//enum MainCellMainTitleType {
//
//}
//
//protocol MainCell {
//    var mainTitle: String { get }
//    var detailsTitle: String { get }
//}
//
//extension MainCell {
//    var unitTitle: String? {
//        ""
//    }
//}
//
//// section
//enum MainSectionHeaderType: String {
//    case info
//    case firstStage = "ПЕРВАЯ СТУПЕНЬ"
//    case secondStage = "ВТОРАЯ СТУПЕНЬ"
//}
//
//protocol MainSection {
//    var header: MainSectionHeaderType { get }
//    var rows: [MainCell] { get }
//}
//
//
//
//// 1
//protocol MainInfoSectionProtocol: MainSection {
//
//}
//
//class MainInfoSection: MainInfoSectionProtocol {
//    var header: MainSectionHeaderType {
//        .info
//    }
//
//    var rows: [MainCell]
//
//    init(rows: [MainCell]) {
//        self.rows = rows
//    }
//}
//
//// 2
//protocol MainFirstStageSectionProtocol: MainSection {
//
//}
//
//class MainFirstStageSection: MainFirstStageSectionProtocol {
//    var header: MainSectionHeaderType {
//        .firstStage
//    }
//
//    var rows: [MainCell]
//
//    init(rows: [MainCell]) {
//        self.rows = rows
//    }
//}
//
//// 3
//protocol MainSecondStageSectionProtocol: MainSection {
//
//}
//
//class MainSecondStageSection: MainSecondStageSectionProtocol {
//    var header: MainSectionHeaderType {
//        .secondStage
//    }
//
//    var rows: [MainCell]
//
//    init(rows: [MainCell]) {
//        self.rows = rows
//    }
//}
//
//// view model
//class MainVM {
//    var sections: [MainSection]
//
//    init(rocket: RocketData) {
//        let infoRows = MainCell(
//        let info = MainInfoSection(rows: <#T##[MainCell]#>)
//    }
//}
