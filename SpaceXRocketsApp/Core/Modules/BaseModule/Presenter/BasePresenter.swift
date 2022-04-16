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
    
    // MARK: - Properties
    weak var view: BaseViewProtocol!
    let networkManager: NetworkManagerProtocol!
    let dataManager: DataManagerProtocol!
    
    // MARK: - Init
    init(view: BaseViewProtocol,
         networkManager: NetworkManagerProtocol,
         dataManager: DataManagerProtocol) {
        self.view = view
        self.networkManager = networkManager
        self.dataManager = dataManager
    }
    
    // MARK: - Methods
    func fetchPages() {
        let url = API.rockets.url
        networkManager.request(fromURL: url) { [unowned self] (result: Result<[RocketModel], Error>) in
            switch result {
            case .success(let rockets):
                dataManager.setRockets(rockets: rockets)
                view.success(withTheNumber: rockets.count)
            case .failure(let error):
                view.failure(error: error)
            }
        }
    }
}
