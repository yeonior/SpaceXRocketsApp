//
//  MainInfoViewModelItem.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 10.04.2022.
//

protocol MainInfoViewModelItemProtocol {
    var company: [String:String] { get }
    var country: [String:String] { get }
    var firstFlight: [String:String] { get }
}

final class MainInfoViewModelItem: MainViewModelItem, MainInfoViewModelItemProtocol {
    
    var sectionType: MainViewModelSectionType {
        .info
    }
    
    var company: [String:String]
    var country: [String:String]
    var firstFlight: [String:String]
    
    init(company: [String:String], country: [String:String], firstFlight: [String:String]) {
        self.company = company
        self.country = country
        self.firstFlight = firstFlight
    }
}

