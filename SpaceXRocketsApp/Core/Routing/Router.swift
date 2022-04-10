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
    func activateBaseModule()
    func activateMainModule(with page: Page)
}

final class Router: Routing {
    
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func activateBaseModule() {
        guard let navigationController = navigationController, let viewController = assemblyBuilder?.buildBaseModule(router: self) else { return }
        navigationController.viewControllers = [viewController]
    }
    
    func activateMainModule(with page: Page) {
        guard let navigationController = navigationController, let viewController = assemblyBuilder?.buildMainModule(with: page) else { return }
        navigationController.viewControllers.append(viewController)
    }
}
