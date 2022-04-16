//
//  MainViewModel.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 11.04.2022.
//

import UIKit

protocol MainItemViewModel {
    var sections: [MainSectionViewModelProtocol] { get }
}

final class MainViewModel: NSObject, MainItemViewModel {
    
    // MARK: - Properties
    var sections = [MainSectionViewModelProtocol]()
    var buttonTapCallback: (() -> ())?
    
    // MARK: - Init
    init(data: RocketData) {
        let info = MainInfoSectionViewModel(firstFlight: data.firstFlight,
                                            country: data.country,
                                            costPerLaunch: data.costPerLaunch)
        
        let firstStage = MainStageSectionViewModel(sectionName: .firstStage,
                                                   engines: data.firstStage.engines,
                                                   fuelAmountTons: data.firstStage.fuelAmountTons,
                                                   burnTimeSEC: data.firstStage.burnTimeSEC)
        
        let secondStage = MainStageSectionViewModel(sectionName: .secondStage,
                                                    engines: data.secondStage.engines,
                                                    fuelAmountTons: data.secondStage.fuelAmountTons,
                                                    burnTimeSEC: data.secondStage.burnTimeSEC)
        
        let button = MainButtonSectionViewModel()
        
        sections.append(info)
        sections.append(firstStage)
        sections.append(secondStage)
        sections.append(button)
    }
}

// MARK: - UITableViewDataSource
extension MainViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = sections[indexPath.section]
        
        switch section.name {
        case .info:
            if let cell = tableView.dequeueReusableCell(withIdentifier: MainInfoSectionCell.identifier, for: indexPath) as? MainInfoSectionCell {
                cell.cellViewModel = section.cells[indexPath.row]
                return cell
            }
        case .firstStage, .secondStage:
            if let cell = tableView.dequeueReusableCell(withIdentifier: MainStageSectionCell.identifier, for: indexPath) as? MainStageSectionCell {
                cell.cellViewModel = section.cells[indexPath.row]
                return cell
            }
        case .button:
            if let cell = tableView.dequeueReusableCell(withIdentifier: MainShowButtonCell.identifier, for: indexPath) as? MainShowButtonCell {
                cell.buttonTapCallback = buttonTapCallback
                return cell
            }
        }
        
        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate
extension MainViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = sections[indexPath.section]
        switch section.name {
        case .button:
            return 60
        default:
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch sections[section].name {
        case .firstStage, .secondStage:
            if let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MainTableViewSectionHeader.identifier) as? MainTableViewSectionHeader {
                header.titleLabel.text = sections[section].name.rawValue
                return header
            }
        default:
            return nil
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch sections[section].name {
        case .firstStage, .secondStage:
            return 40
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch sections[section].name {
        case .info, .firstStage:
            return 20
        case .secondStage, .button:
            return 32
        }
    }
}
