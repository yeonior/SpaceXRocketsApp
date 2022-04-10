//
//  MainPresenter.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 10.04.2022.
//

import Foundation

protocol MainPresenterProtocol {
    init(view: MainViewProtocol, dataManager: DataManagerProtocol)
    func provideInfo(by serialNumber: Int)
}

final class MainPresenter: MainPresenterProtocol {
    
    weak var view: MainViewProtocol!
    let dataManager: DataManagerProtocol!
    var page: Page?
    
    init(view: MainViewProtocol, dataManager: DataManagerProtocol) {
        self.view = view
        self.dataManager = dataManager
    }
    
    func provideInfo(by serialNumber: Int) {
        let rockets = dataManager.getRockets()
        let index = serialNumber - 1
        let rocket = rockets[index]
        let page = Page(rocket: rocket)
        let imageData = dataManager.getData(from: page.backgroundImages.first!)
        view.setBackgroundImage(with: imageData)
    }
}
