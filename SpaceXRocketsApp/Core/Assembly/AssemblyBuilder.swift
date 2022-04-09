//
//  AssemblyBuilder.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 08.04.2022.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func buildMainModule(router: Routing) -> UIViewController
}

final class AssemblyBuilder: AssemblyBuilderProtocol {
    func buildMainModule(router: Routing) -> UIViewController {
        
        let networkManager = NetworkManager.shared
        
        let view = BasePageViewController(transitionStyle: .scroll,
                                          navigationOrientation: .horizontal,
                                          options: nil)
        let presenter = BasePresenter(networkManager: networkManager, view: view)
        
        presenter.view = view
        view.presenter = presenter
        view.viewControllersToDisplay = [MainViewController(),
                                         MainViewController(),
                                         MainViewController(),
                                         MainViewController()]
        
        return view
    }
}
    
