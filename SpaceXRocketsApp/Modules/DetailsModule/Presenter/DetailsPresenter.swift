//
//  DetailsPresenter.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 12.04.2022.
//

protocol DetailsPresenterProtocol {
    init(view: DetailsViewProtocol, networkManager: NetworkManagerProtocol, dataManager: DataManagerProtocol)
    func fetchLaunches()
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
    
    func fetchLaunches() {
        let url = API.launches.url
        networkManager.request(fromURL: url) { (result: Result<[LaunchModel], Error>) in
            switch result {
            case .success(_):
                self.view.success()
            case .failure(let error):
                self.view.failure(error: error)
            }
        }
    }
}
