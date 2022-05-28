//
//  AssemblyBuilder.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 08.04.2022.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func buildBaseModule(router: Routing) -> UIViewController
    func buildMainModule(with serialNumber: Int, router: Routing) -> MainViewController
    func buildDetailsModule(with serialNumber: Int, router: Routing) -> DetailsViewController
    func buildSettingsModule(router: Routing) -> SettingsViewController
}

final class AssemblyBuilder: AssemblyBuilderProtocol {
    
    // MARK: - Properties
    let dataManager = DataManager.shared
    let networkManager = NetworkManager.shared
    
    // MARK: - Methods
    func buildBaseModule(router: Routing) -> UIViewController {
        
        let view = BasePageViewController(transitionStyle: .scroll,
                                          navigationOrientation: .horizontal,
                                          options: nil)
        let presenter = BasePresenter(view: view,
                                      dataManager: dataManager,
                                      networkManager: networkManager)
        
        view.router = router
        view.presenter = presenter
        presenter.view = view
        
        return view
    }
    
    func buildMainModule(with serialNumber: Int, router: Routing) -> MainViewController {
        
        let view = MainViewController()
        let presenter = MainPresenter(view: view,
                                      dataManager: dataManager)
        
        view.router = router
        view.presenter = presenter
        view.serialNumber = serialNumber
        presenter.view = view
        
        return view
    }
    
    func buildDetailsModule(with serialNumber: Int, router: Routing) -> DetailsViewController {
        
        let view = DetailsViewController()
        let presenter = DetailsPresenter(view: view,
                                         dataManager: dataManager,
                                         networkManager: networkManager)
        
        view.router = router
        view.presenter = presenter
        view.serialNumber = serialNumber
        presenter.view = view
        
        return view
    }
    
    func buildSettingsModule(router: Routing) -> SettingsViewController {
        
        let view = SettingsViewController()
        let presenter = SettingsPresenter(view: view, dataManager: dataManager)
        
        view.router = router
        view.presenter = presenter
        presenter.view = view
        
        return view
    }
}
