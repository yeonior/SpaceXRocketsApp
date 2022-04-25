//
//  SettingsPresenter.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 25.04.2022.
//

protocol SettingPresenterProtocol {
    
}

final class SettingsPresenter: SettingPresenterProtocol {
    
    // MARK: - Properties
    weak var view: SettingsViewProtocol!
    
    // MARK: - Init
    init(view: SettingsViewProtocol) {
        self.view = view
    }
}
