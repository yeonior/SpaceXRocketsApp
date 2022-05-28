//
//  DetailsPresenter.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 12.04.2022.
//

import Foundation

protocol DetailsPresenterProtocol {
    init(view: DetailsViewProtocol,
         dataManager: DataManagerProtocol,
         networkManager: NetworkManagerProtocol)
    func fetchData()
    func provideViewModel(with serialNumber: Int)
}

final class DetailsPresenter: DetailsPresenterProtocol {
    
    // MARK: - Properties
    weak var view: DetailsViewProtocol!
    unowned let dataManager: DataManagerProtocol!
    let networkManager: NetworkManagerProtocol!
    
    // MARK: - Init
    init(view: DetailsViewProtocol,
         dataManager: DataManagerProtocol,
         networkManager: NetworkManagerProtocol) {
        self.view = view
        self.dataManager = dataManager
        self.networkManager = networkManager
    }
    
    // MARK: - Methods
    func fetchData() {
        let url = APIs.launches.url
        networkManager.request(fromURL: url) { (result: Result<[LaunchModel], Error>) in
            switch result {
            case .success(let launches):
                self.dataManager.setLaunches(launches)
                self.view.success()
            case .failure(let error):
                self.view.failure(error: error)
            }
        }
    }
    
    func provideViewModel(with serialNumber: Int) {
        
        // getting data
        let rocket = dataManager.getRockets()[serialNumber - 1]
        
        // getting the current date
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.yyyyMMddTHHmmssZ.rawValue
        let stringDate = dateFormatter.string(from: currentDate)
        
        // filtering all launches by serial number
        let laucnhes = dataManager.getLaunches().filter { $0.rocketId == rocket.id }
        
        // filtering the launches till current date
        let filteredLaucnhes = laucnhes.filter { stringDate > $0.dateLocal }
        
        // sorting the laucnhes by date
        let sortedLaunches = filteredLaucnhes.sorted { dateFormatter.date(from: $0.dateLocal)! > dateFormatter.date(from: $1.dateLocal)! }
        
        // view model
        let viewModel = DetailsCollectionViewModel(data: sortedLaunches)
        view.setViewModel(viewModel)
    }
}
