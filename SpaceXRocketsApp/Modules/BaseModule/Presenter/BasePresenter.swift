//
//  BasePresenter.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 08.04.2022.
//

import Foundation

protocol BasePresenterProtocol {
//    var pages: [Page]? { get set }
    init(view: BaseViewProtocol, networkManager: NetworkManagerProtocol)
    func fetchPages()
}

final class BasePresenter: BasePresenterProtocol {
    
    weak var view: BaseViewProtocol!
    let networkManager: NetworkManagerProtocol!
//    var pages: [Page]?
    
    init(view: BaseViewProtocol, networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
        self.view = view
    }
    
    func fetchPages() {
        let url = API.rockets.url
        networkManager.request(fromURL: url) { (result: Result<[Rocket], Error>) in
            switch result {
            case .success(let rockets):
                DataManager.shared.setRockets(rockets: rockets)
                self.view.success(withTheNumber: rockets.count)
            case .failure(let error):
                self.view.failure(error: error)
            }
        }
    }
}