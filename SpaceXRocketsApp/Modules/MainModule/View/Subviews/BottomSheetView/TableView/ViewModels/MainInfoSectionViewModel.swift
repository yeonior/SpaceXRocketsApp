//
//  MainInfoSectionViewModel.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 11.04.2022.
//

final class MainInfoSectionViewModel: MainSectionViewModelProtocol {
    var sectionName: MainSectionType {
        .info
    }
    
    var cells: [MainCellViewModelProtocol]
    
    init(country: String, company: String, firstFlight: String) {
        let countryCell = MainCellViewModel(text: .country, detailText: country)
        let companyCell = MainCellViewModel(text: .company, detailText: company)
        let firstLaunchCell = MainCellViewModel(text: .firstFlight, detailText: firstFlight)
        let cells = [countryCell, companyCell, firstLaunchCell]
        self.cells = cells
    }
}
