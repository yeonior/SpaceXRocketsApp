//
//  AssemblyBuilder.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 08.04.2022.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func buildBaseModule(router: Routing) -> UIViewController
    func buildMainModule(with serialNumber: Int) -> MainViewController
}

final class AssemblyBuilder: AssemblyBuilderProtocol {
    func buildBaseModule(router: Routing) -> UIViewController {
        
        let networkManager = NetworkManager.shared
        
        let view = BasePageViewController(transitionStyle: .scroll,
                                          navigationOrientation: .horizontal,
                                          options: nil)
        let presenter = BasePresenter(view: view, networkManager: networkManager)
        
        view.router = router
        view.presenter = presenter
        presenter.view = view
        
        return view
    }
    
    func buildMainModule(with serialNumber: Int) -> MainViewController {
        
        let dataManager = DataManager.shared
        let view = MainViewController()
        let presenter = MainPresenter(view: view, dataManager: dataManager)
        
        view.presenter = presenter
        view.serialNumber = serialNumber
        presenter.view = view
        
        return view
    }
}
    
