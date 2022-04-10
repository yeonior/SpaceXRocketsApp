//
//  MainPresenter.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 10.04.2022.
//

import Foundation

protocol MainPresenterProtocol {
    init(view: MainViewProtocol, dataManager: DataManagerProtocol)
    func provideInfo(by serialNumber: Int)
}

final class MainPresenter: MainPresenterProtocol {
    
    weak var view: MainViewProtocol!
    let dataManager: DataManagerProtocol!
    
    init(view: MainViewProtocol, dataManager: DataManagerProtocol) {
        self.view = view
        self.dataManager = dataManager
    }
    
    func provideInfo(by serialNumber: Int) {
        let rockets = dataManager.getRockets()
        let index = serialNumber - 1
        let rocket = rockets[index]
        let imageData = dataManager.getData(from: rocket.flickrImages.first!)
        view.setBackgroundImage(with: imageData)
        
        let rocketData = RocketData(rocket: rocket)
        let infoSection = MainInfoSectionViewModel()
        rockets.forEach { rocket in
            let viewModel = MainInfoSectionCellViewModel(rocketData: rocketData)
            infoSection.rows.append(viewModel)
        }
        
//        infoSection.rows.append(MainInfoSectionCellViewModel(mainTitle: "Страна", detailsTitle: rocket.country))
//        infoSection.rows.append(MainInfoSectionCellViewModel(mainTitle: "Компания", detailsTitle: rocket.company))
//        infoSection.rows.append(MainInfoSectionCellViewModel(mainTitle: "Первый полет", detailsTitle: rocket.firstFlight))
        view.setInfoSection(with: infoSection)
    }
}
