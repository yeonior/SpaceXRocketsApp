//
//  Router.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 08.04.2022.
//

import UIKit

protocol RouterProtocol {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

protocol Routing: RouterProtocol {
    func instantiateBaseModule()
    func instantiateMainModule(with: Page)
}

final class Router: Routing {
    
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func instantiateBaseModule() {
        guard let navigationController = navigationController, let initialViewController = assemblyBuilder?.buildMainModule(router: self) else { return }
        navigationController.viewControllers = [initialViewController]
    }
    
    func instantiateMainModule(with: Page) {
        
    }
}
