//
//  MainPresenter.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 10.04.2022.
//

import Foundation

protocol MainPresenterProtocol {
    init(view: MainViewProtocol, dataManager: DataManagerProtocol)
    func fetchData(by serialNumber: Int)
    func provideBackgroundImage()
    func provideRocketName()
    func provideViewModel()
}

final class MainPresenter: MainPresenterProtocol {
    
    weak var view: MainViewProtocol!
    let dataManager: DataManagerProtocol!
    var rocketData: RocketData?
    
    init(view: MainViewProtocol, dataManager: DataManagerProtocol) {
        self.view = view
        self.dataManager = dataManager
    }
    
    func fetchData(by serialNumber: Int) {
        let rockets = dataManager.getRockets()
        let rocket = rockets[serialNumber - 1]
        let rocketData = RocketData(
            id: rocket.id,
            flickrImages: rocket.flickrImages,
            name: rocket.name,
            firstFlight: rocket.firstFlight,
            country: rocket.country,
            costPerLaunch: rocket.costPerLaunch,
            firstStage: RocketData.Stage(engines: rocket.firstStage.engines,
                                              fuelAmountTons: rocket.firstStage.fuelAmountTons,
                                              burnTimeSEC: rocket.firstStage.burnTimeSEC),
            secondStage: RocketData.Stage(engines: rocket.secondStage.engines,
                                                fuelAmountTons: rocket.secondStage.fuelAmountTons,
                                                burnTimeSEC: rocket.secondStage.burnTimeSEC)
        )
        
        self.rocketData = rocketData
    }
    
    func provideBackgroundImage() {
        guard let rocketData = rocketData else { return }
        let imageData = dataManager.getData(from: rocketData.flickrImages.randomElement()!)
        view.setBackgroundImage(with: imageData)
    }
    
    func provideRocketName() {
        guard let rocketData = rocketData else { return }
        let name = rocketData.name
        view.setName(name)
    }
    
    func provideViewModel() {
        guard let rocketData = rocketData else { return }
        let viewModel = MainViewModel(data: rocketData)
        view.setViewModel(viewModel)
    }
}
