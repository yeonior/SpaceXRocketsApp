//
//  AssemblyBuilder.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 08.04.2022.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func buildBaseModule(router: Routing) -> UIViewController
    func buildMainModule(with page: Page) -> MainViewController
}

final class AssemblyBuilder: AssemblyBuilderProtocol {
    func buildBaseModule(router: Routing) -> UIViewController {
        
        let networkManager = NetworkManager.shared
        
        let view = BasePageViewController(transitionStyle: .scroll,
                                          navigationOrientation: .horizontal,
                                          options: nil)
        let presenter = BasePresenter(networkManager: networkManager, view: view)
        
        view.router = router
        view.presenter = presenter
        presenter.view = view
        
        return view
    }
    
    func buildMainModule(with page: Page) -> MainViewController {
        
        let view = MainViewController()
        let presenter = MainPresenter(view: view)
        
        presenter.view = view
        view.presenter = presenter
        // TEMP
        view.page = page
        
        return view
    }
}
    
