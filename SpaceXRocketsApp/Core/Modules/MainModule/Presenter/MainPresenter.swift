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
    func provideTableViewModel()
    func provideCollectionViewModel()
}

final class MainPresenter: MainPresenterProtocol {
    
    // MARK: - Properties
    weak var view: MainViewProtocol!
    let dataManager: DataManagerProtocol!
    var rocketData: RocketData?
    
    // MARK: - Init
    init(view: MainViewProtocol, dataManager: DataManagerProtocol) {
        self.view = view
        self.dataManager = dataManager
    }
    
    // MARK: - Methods
    func fetchData(by serialNumber: Int) {
        let rockets = dataManager.getRockets()
        let rocket = rockets[serialNumber - 1]
        let rocketData = RocketData(
            id: rocket.id,
            flickrImages: rocket.flickrImages,
            name: rocket.name,
            height: rocket.height,
            diameter: rocket.diameter,
            mass: rocket.mass,
            payloadWeights: rocket.payloadWeights,
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
        // providing a random image
        let imageData = dataManager.getData(from: rocketData.flickrImages.randomElement()!)
        view.setBackgroundImage(with: imageData)
    }
    
    func provideRocketName() {
        guard let rocketData = rocketData else { return }
        let name = rocketData.name
        view.setName(name)
    }
    
    func provideTableViewModel() {
        guard let rocketData = rocketData else { return }
        let viewModel = MainTableViewModel(data: rocketData)
        view.setTableViewModel(viewModel)
    }
    
    func provideCollectionViewModel() {
        guard let rocketData = rocketData else { return }
        let viewModel = MainCollectionViewModel(data: [rocketData])
        view.setCollectionViewModel(viewModel)
    }
}
