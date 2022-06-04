//
//  MainPresenter.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 10.04.2022.
//

import Foundation

protocol MainPresenterProtocol {
    init(view: MainViewProtocol, dataManager: DataManagerProtocol)
    func requestData(by serialNumber: Int)
    func provideCollectionViewViewModel()
    func provideData()
}

final class MainPresenter: MainPresenterProtocol {
    
    // MARK: - Properties
    weak var view: MainViewProtocol!
    let dataManager: DataManagerProtocol!
    var rocketData: RocketData?
    let dispatchGroup = DispatchGroup()
    
    // MARK: - Init
    init(view: MainViewProtocol, dataManager: DataManagerProtocol) {
        self.view = view
        self.dataManager = dataManager
    }
    
    // MARK: - Methods
    func requestData(by serialNumber: Int) {
        let rockets = dataManager.getRockets()
        let rocket = rockets[serialNumber - 1]
        
        // parameters
        var height: String {
            switch dataManager.getLengthUnit(for: Parameter.height.rawValue) {
            case .feet:
                guard let newValue = rocket.height.feet else { return Parameter.unknown.rawValue }
                return String(newValue)
            case .meters:
                guard let newValue = rocket.height.meters else { return Parameter.unknown.rawValue }
                return String(newValue)
            }
        }
        
        var diameter: String {
            switch dataManager.getLengthUnit(for: Parameter.diameter.rawValue) {
            case .feet:
                guard let newValue = rocket.diameter.feet else { return Parameter.unknown.rawValue }
                return String(newValue)
            case .meters:
                guard let newValue = rocket.diameter.meters else { return Parameter.unknown.rawValue }
                return String(newValue)
            }
        }
        
        var mass: String {
            switch dataManager.getMassUnit(for: Parameter.mass.rawValue) {
            case .kilos: return TextFormatter.numberWithCommas(rocket.mass.kg)
            case .pounds: return TextFormatter.numberWithCommas(rocket.mass.lb)
            }
        }
        
        var payloadWeight: String {
            for payloadWeight in rocket.payloadWeights {
                // checking the leo weight
                guard payloadWeight.id == "leo" else { return Parameter.unknown.rawValue }
                switch dataManager.getMassUnit(for: Parameter.payload.rawValue) {
                case .kilos: return TextFormatter.numberWithCommas(payloadWeight.kg)
                case .pounds: return TextFormatter.numberWithCommas(payloadWeight.lb)
                }
            }
            return Parameter.unknown.rawValue
        }
        
        // units
        var heightUnit: String {
            switch dataManager.getLengthUnit(for: Parameter.height.rawValue) {
            case .feet: return Parameter.height.rawValue + ", " + LengthUnit.feet.rawValue
            case .meters: return Parameter.height.rawValue + ", " + LengthUnit.meters.rawValue
            }
        }
        
        var diameterUnit: String {
            switch dataManager.getLengthUnit(for: Parameter.diameter.rawValue) {
            case .feet: return Parameter.diameter.rawValue + ", " + LengthUnit.feet.rawValue
            case .meters: return Parameter.diameter.rawValue + ", " + LengthUnit.meters.rawValue
            }
        }
        
        var massUnit: String {
            switch dataManager.getMassUnit(for: Parameter.mass.rawValue) {
            case .kilos: return Parameter.mass.rawValue + ", " + MassUnit.kilos.rawValue
            case .pounds: return Parameter.mass.rawValue + ", " + MassUnit.pounds.rawValue
            }
        }
        
        var payloadWeightUnit: String {
            for payloadWeight in rocket.payloadWeights {
                // checking the leo weight
                guard payloadWeight.id == "leo" else { return Parameter.unknown.rawValue }
                switch dataManager.getMassUnit(for: Parameter.payload.rawValue) {
                case .kilos: return Parameter.payload.rawValue + ", " + MassUnit.kilos.rawValue
                case .pounds: return Parameter.payload.rawValue + ", " + MassUnit.pounds.rawValue
                }
            }
            return Parameter.unknown.rawValue
        }
        
        // model
        let rocketData = RocketData(
            id: rocket.id,
            flickrImages: rocket.flickrImages,
            name: rocket.name,
            height: RocketData.Parameter(value: height, unit: heightUnit),
            diameter: RocketData.Parameter(value: diameter, unit: diameterUnit),
            mass: RocketData.Parameter(value: mass, unit: massUnit),
            payloadWeight: RocketData.Parameter(value: payloadWeight, unit: payloadWeightUnit),
            firstFlight: rocket.firstFlight,
            country: rocket.country,
            costPerLaunch: rocket.costPerLaunch,
            firstStage: RocketData.Stage(engines: rocket.firstStage.engines,
                                         fuelAmountTons: rocket.firstStage.fuelAmountTons,
                                         burnTimeSec: rocket.firstStage.burnTimeSec),
            secondStage: RocketData.Stage(engines: rocket.secondStage.engines,
                                          fuelAmountTons: rocket.secondStage.fuelAmountTons,
                                          burnTimeSec: rocket.secondStage.burnTimeSec)
        )
        
        self.rocketData = rocketData
    }
    
    func provideCollectionViewViewModel() {
        guard let rocketData = rocketData else { return }
        let viewModel = MainCollectionViewViewModel(data: [rocketData])
        DispatchQueue.main.sync {
            view.setCollectionViewViewModel(viewModel)
        }
    }
    
    func provideData() {
        guard let rocketData = rocketData else { return }
        
        var imageData: Data?
        var name: String?
        var collectionViewViewModel: MainCollectionViewViewModel?
        var tableViewViewModel: MainTableViewViewModel?
        
        let backgroundImageWorkItem = DispatchWorkItem {
            imageData = self.dataManager.fetchData(from: rocketData.flickrImages.randomElement()!)
        }
        
        let rocketNameWorkItem = DispatchWorkItem {
            name = rocketData.name
        }
        
        let collectionViewViewModelWorkItem = DispatchWorkItem {
            collectionViewViewModel = MainCollectionViewViewModel(data: [rocketData])
        }
        
        let tableViewViewModelWorkItem = DispatchWorkItem {
            tableViewViewModel = MainTableViewViewModel(data: rocketData)
        }
        
        DispatchQueue.global().async(group: dispatchGroup, execute: backgroundImageWorkItem)
        DispatchQueue.global().async(group: dispatchGroup, execute: rocketNameWorkItem)
        DispatchQueue.global().async(group: dispatchGroup, execute: collectionViewViewModelWorkItem)
        DispatchQueue.global().async(group: dispatchGroup, execute: tableViewViewModelWorkItem)
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            guard let imageData = imageData,
                let name = name,
                let collectionViewViewModel = collectionViewViewModel,
                let tableViewViewModel = tableViewViewModel else { return }
            
            self.view.setBackgroundImage(from: imageData)
            self.view.setHeaderViewWithName(name)
            self.view.setCollectionViewViewModel(collectionViewViewModel)
            self.view.setTableViewViewModel(tableViewViewModel)
            self.view.removeCoverView()
        }
    }
}
