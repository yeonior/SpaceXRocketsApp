//
//  MainPresenter.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 10.04.2022.
//

import Foundation

protocol MainPresenterProtocol {
    init(view: MainViewProtocol, dataManager: DataManagerProtocol)
    func provideData(by serialNumber: Int)
}

final class MainPresenter: MainPresenterProtocol {
    
    weak var view: MainViewProtocol!
    let dataManager: DataManagerProtocol!
    var rocketData: RocketData?
    
    init(view: MainViewProtocol, dataManager: DataManagerProtocol) {
        self.view = view
        self.dataManager = dataManager
    }
    
    func provideData(by serialNumber: Int) {
        let rockets = dataManager.getRockets()
        let rocket = rockets[serialNumber - 1]
        let rocketData = RocketData(
            firstStage: RocketData.FirstStage(engines: rocket.firstStage.engines,
                                              fuelAmountTons: rocket.firstStage.fuelAmountTons,
                                              burnTimeSEC: rocket.firstStage.burnTimeSEC),
            secondStage: RocketData.SecondStage(engines: rocket.secondStage.engines,
                                                fuelAmountTons: rocket.secondStage.fuelAmountTons,
                                                burnTimeSEC: rocket.secondStage.burnTimeSEC),
            firstFlight: rocket.firstFlight,
            country: rocket.country,
            company: rocket.company,
            flickrImages: rocket.flickrImages
        )
        
        self.rocketData = rocketData
        
        let imageData = dataManager.getData(from: rocketData.flickrImages.first!)
        view.setBackgroundImage(with: imageData)
        
        let viewModel = MainViewModel(data: rocketData)
        view.setViewModel(viewModel: viewModel)
    }
}
