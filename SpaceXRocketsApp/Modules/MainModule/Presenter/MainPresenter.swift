//
//  MainPresenter.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 10.04.2022.
//

import Foundation

protocol MainPresenterProtocol {
    init(view: MainViewProtocol)
}

final class MainPresenter: MainPresenterProtocol {
    
    weak var view: MainViewProtocol!
    var page: Page?
    
    init(view: MainViewProtocol) {
        self.view = view
    }
}
