//
//  MainPresenter.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 08.04.2022.
//

import Foundation

protocol MainPresenterProtocol {
    init(networkManager: NetworkManagerProtocol, view: MainViewProtocol)
    var pages: [MainPageModel]? { get set }
    func fetchPages()
}

final class MainPresenter: MainPresenterProtocol {
    
    weak var view: MainViewProtocol!
    let networkManager: NetworkManagerProtocol!
    var pages: [MainPageModel]?
    
    init(networkManager: NetworkManagerProtocol, view: MainViewProtocol) {
        self.networkManager = networkManager
        self.view = view
    }
    
    func fetchPages() {
        let url = API.rockets.url
        networkManager.request(fromURL: url) { (result: Result<[RocketModel], Error>) in
            switch result {
            case .success(let rockets):
                var pages: [MainPageModel] = []
                for rocket in rockets {
                    pages.append(MainPageModel(rocket: rocket))
                }
                self.pages = pages
                self.view.success()
            case .failure(let error):
                self.view.failure(error: error)
            }
        }
    }
}
