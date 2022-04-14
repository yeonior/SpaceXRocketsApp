//
//  DetailsPresenter.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 12.04.2022.
//

import Foundation

protocol DetailsPresenterProtocol {
    init(view: DetailsViewProtocol, networkManager: NetworkManagerProtocol, dataManager: DataManagerProtocol)
    func fetchData()
    func provideViewModel(with serialNumber: Int)
}

final class DetailsPresenter: DetailsPresenterProtocol {
    
    weak var view: DetailsViewProtocol!
    let networkManager: NetworkManagerProtocol!
    let dataManager: DataManagerProtocol!
    
    init(view: DetailsViewProtocol, networkManager: NetworkManagerProtocol, dataManager: DataManagerProtocol) {
        self.view = view
        self.networkManager = networkManager
        self.dataManager = dataManager
    }
    
    func fetchData() {
        let url = API.launches.url
        networkManager.request(fromURL: url) { (result: Result<[LaunchModel], Error>) in
            switch result {
            case .success(let launches):
                self.dataManager.setLaunches(launches: launches)
                self.view.success()
            case .failure(let error):
                self.view.failure(error: error)
            }
        }
    }
    
    func provideViewModel(with serialNumber: Int) {
        
        // getting data
        let rockets = dataManager.getRockets()
        let launches = dataManager.getLaunches()
        let rocket = rockets[serialNumber - 1]
        
        // extracting launches by serial number
        var array: [LaunchModel] = []
        for launch in launches {
            if launch.rocketId == rocket.id {
                array.append(launch)
            }
        }
        
        // sorting laucnhes by date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.yyyyMMddTHHmmssZ.rawValue
        array.sort { dateFormatter.date(from: $0.dateLocal)! > dateFormatter.date(from: $1.dateLocal)! }
        
        // viewModel
        let viewModel = DetailsViewModel(data: array)
        view.setViewModel(viewModel)
    }
}
