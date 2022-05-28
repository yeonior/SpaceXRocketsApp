//
//  BasePresenter.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 08.04.2022.
//

import Foundation

protocol BasePresenterProtocol {
    init(view: BaseViewProtocol,
         dataManager: DataManagerProtocol,
         networkManager: NetworkManagerProtocol)
    func fetchPages()
}

final class BasePresenter: BasePresenterProtocol {
    
    // MARK: - Properties
    weak var view: BaseViewProtocol!
    unowned let dataManager: DataManagerProtocol!
    let networkManager: NetworkManagerProtocol!
    
    // MARK: - Init
    init(view: BaseViewProtocol,
         dataManager: DataManagerProtocol,
         networkManager: NetworkManagerProtocol) {
        self.view = view
        self.dataManager = dataManager
        self.networkManager = networkManager
    }
    
    // MARK: - Methods
    func fetchPages() {
        let url = APIs.rockets.url
        networkManager.request(fromURL: url) { (result: Result<[RocketModel], Error>) in
            switch result {
            case .success(let rockets):
                self.dataManager.setRockets(rockets)
                self.view.success(withNumber: rockets.count)
            case .failure(let error):
                self.view.failure(error: error)
            }
        }
    }
}
