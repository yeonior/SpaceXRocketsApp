//
//  MainPresenter.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 08.04.2022.
//

import Foundation

protocol MainViewProtocol {
    func success()
    func failure(error: Error)
}

protocol MainPresenterProtocol {
    init(networkService: NetworkManagerProtocol, view: MainViewProtocol)
    var pages: [MainPageModel]? { get set }
}

final class MainPresenter {
    
}
