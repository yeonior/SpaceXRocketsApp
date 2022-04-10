//
//  BasePresenter.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 08.04.2022.
//

import Foundation

protocol BasePresenterProtocol {
    init(networkManager: NetworkManagerProtocol, view: BaseViewProtocol)
    var pages: [Page] { get set }
    func fetchPages()
//    func getPage(at: IndexPath)
}

final class BasePresenter: BasePresenterProtocol {
    
    weak var view: BaseViewProtocol!
    let networkManager: NetworkManagerProtocol!
    var pages: [Page] = []
    
    init(networkManager: NetworkManagerProtocol, view: BaseViewProtocol) {
        self.networkManager = networkManager
        self.view = view
    }
    
    func fetchPages() {
        let url = API.rockets.url
        networkManager.request(fromURL: url) { (result: Result<[Rocket], Error>) in
            switch result {
            case .success(let rockets):
                for rocket in rockets {
                    self.pages.append(Page(rocket: rocket))
                }
                self.view.success()
            case .failure(let error):
                self.view.failure(error: error)
            }
        }
    }
}
