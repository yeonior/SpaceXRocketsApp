//
//  DetailsPresenter.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 12.04.2022.
//

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
        let rockets = dataManager.getRockets()
        let index = serialNumber - 1
        let rocket = rockets[index]
        let rocketId = rocket.id
        let launches = dataManager.getLaunches()
        
        var laucnhesForRocket: [LaunchModel] = []
        for launch in launches {
            if launch.rocketId == rocketId {
                laucnhesForRocket.append(launch)
            }
        }
        let viewModel = DetailsViewModel(data: laucnhesForRocket)
        view.setViewModel(viewModel)
    }
}
