//
//  BasePresenter.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 08.04.2022.
//

import Foundation

protocol BasePresenterProtocol {
    init(view: BaseViewProtocol, networkManager: NetworkManagerProtocol, dataManager: DataManagerProtocol)
    func fetchPages()
}

final class BasePresenter: BasePresenterProtocol {
    
    weak var view: BaseViewProtocol!
    let networkManager: NetworkManagerProtocol!
    let dataManager: DataManagerProtocol!
    
    init(view: BaseViewProtocol,
         networkManager: NetworkManagerProtocol,
         dataManager: DataManagerProtocol) {
        self.view = view
        self.networkManager = networkManager
        self.dataManager = dataManager
    }
    
    func fetchPages() {
        let url = API.rockets.url
        networkManager.request(fromURL: url) { (result: Result<[RocketModel], Error>) in
            switch result {
            case .success(let rockets):
                self.dataManager.setRockets(rockets: rockets)
                self.view.success(withTheNumber: rockets.count)
            case .failure(let error):
                self.view.failure(error: error)
            }
        }
    }
}
