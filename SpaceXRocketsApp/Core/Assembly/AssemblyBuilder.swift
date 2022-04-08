//
//  AssemblyBuilder.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 08.04.2022.
//

import UIKit

protocol AssemblyBuilderProtocol {
    static func buildMainModule() -> UIViewController
}

final class AssemblyBuilder: AssemblyBuilderProtocol {
    static func buildMainModule() -> UIViewController {
        
        let networkManager = NetworkManager.shared
        
        let view = MainPageViewController(transitionStyle: .scroll,
                                          navigationOrientation: .horizontal,
                                          options: nil)
        let presenter = MainPresenter(networkManager: networkManager, view: view)
        
        presenter.view = view
        view.presenter = presenter
        view.viewControllersToDisplay = [MainViewController(),
                                         MainViewController(),
                                         MainViewController(),
                                         MainViewController()]
        
        return view
    }
}
