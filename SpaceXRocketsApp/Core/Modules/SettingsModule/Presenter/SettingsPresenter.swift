//
//  SettingsPresenter.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 25.04.2022.
//

protocol SettingPresenterProtocol {
    func provideTitles()
    func provideSegmentedControlTitles()
}

final class SettingsPresenter: SettingPresenterProtocol {
    
    // MARK: - Properties
    weak var view: SettingsViewProtocol!
    let dataManager: DataManagerProtocol!
    
    // MARK: - Init
    init(view: SettingsViewProtocol, dataManager: DataManagerProtocol) {
        self.view = view
        self.dataManager = dataManager
    }
    
    func provideTitles() {
        let array = ["Height", "Diameter", "Mass", "Payload"]
        view.setLabelTitles(with: array)
    }
    
    func provideSegmentedControlTitles() {
        let dict = [[0: "m", 1: "ft"],
                    [0: "m", 1: "ft"],
                    [0: "kg", 1: "lb"],
                    [0: "kg", 1: "lb"]]
        view.setSegmentedControlTitles(with: dict)
    }
}
