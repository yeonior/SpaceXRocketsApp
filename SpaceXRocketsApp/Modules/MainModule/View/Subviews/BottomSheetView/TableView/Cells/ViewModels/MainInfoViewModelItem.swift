//
//  MainInfoViewModelItem.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 10.04.2022.
//

protocol MainInfoViewModelItemProtocol {
    var company: String { get }
    var country: String { get }
    var firstFlight: String { get }
}

final class MainInfoViewModelItem: MainViewModelItem, MainInfoViewModelItemProtocol {
    
    var sectionType: MainViewModelSectionType {
        .info
    }
    
    var company: String
    var country: String
    var firstFlight: String
    
    init(company: String, country: String, firstFlight: String) {
        self.company = company
        self.country = country
        self.firstFlight = firstFlight
    }
}

