//
//  DetailsPresenter.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 12.04.2022.
//

protocol DetailsPresenterProtocol {
    
}

final class DetailsPresenter: DetailsPresenterProtocol {
    
    weak var view: DetailsViewProtocol!
    let dataManager: DataManagerProtocol!
    
    init(view: DetailsViewProtocol, dataManager: DataManagerProtocol) {
        self.view = view
        self.dataManager = dataManager
    }
}
