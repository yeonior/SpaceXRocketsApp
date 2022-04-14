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
    var sections = [MainSectionViewModelProtocol]()
    var buttonTapCallback: (() -> ())?
    
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
            if let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as? MainInfoSectionCell {
                cell.cellViewModel = section.cells[indexPath.row]
                return cell
            }
        case .firstStage, .secondStage:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "stageCell", for: indexPath) as? MainStageSectionCell {
                cell.cellViewModel = section.cells[indexPath.row]
                return cell
            }
        case .button:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "buttonCell", for: indexPath) as? MainShowButtonCell {
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
        indexPath.section == 3 ? 60 : 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0, 3:
            return nil
        default:
            if let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "sectionHeader") as? MainTableViewSectionHeader {
                header.titleLabel.text = sections[section].name.rawValue
                return header
            }
            return UITableViewHeaderFooterView()
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0, 3:
            return 0
        default:
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 0, 1:
            return 20
        case 2, 3:
            return 32
        default:
            return 0
        }
    }
}
