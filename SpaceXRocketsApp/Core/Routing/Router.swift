//
//  Router.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 08.04.2022.
//

import UIKit

protocol RouterProtocol {
    var navigationController: UINavigationController? { get }
    var assemblyBuilder: AssemblyBuilderProtocol! { get }
}

protocol Routing: RouterProtocol {
    func activateBaseModule()
    func activateMainModule(with serialNumber: Int) -> MainViewController
    func provideEmptyMainViewController() -> MainViewController
    func showDetailsModule(with serialNumber: Int, and name: String)
}

final class Router: Routing {
    
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol!
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func activateBaseModule() {
        guard let navigationController = navigationController else { return }
                
        let viewController = assemblyBuilder.buildBaseModule(router: self)
        navigationController.viewControllers = [viewController]
    }
    
    func activateMainModule(with serialNumber: Int) -> MainViewController {
        assemblyBuilder.buildMainModule(with: serialNumber, router: self)
    }
    
    func provideEmptyMainViewController() -> MainViewController {
        MainViewController()
    }
    
    func showDetailsModule(with serialNumber: Int, and name: String) {
        guard let navigationController = navigationController else { return }
        
        let viewController = assemblyBuilder.buildDetailsModule(with: serialNumber, router: self)
        viewController.modalPresentationStyle = .automatic
        viewController.title = name
        navigationController.pushViewController(viewController, animated: true)
    }
}
