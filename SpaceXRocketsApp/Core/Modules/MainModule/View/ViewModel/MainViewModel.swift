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

private struct MainTableViewSizeConstants {
    static let cellHeight: CGFloat = 50.0
    static let buttonCellHeight: CGFloat = 60.0
    static let sectionHeaderHeight: CGFloat = 0.0
    static let stageSectionHeaderHeight: CGFloat = 40.0
    static let firstHalfSectionFooterHeight: CGFloat = 20.0
    static let secondHalfSectionFooterHeight: CGFloat = 32.0
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
            return MainTableViewSizeConstants.buttonCellHeight
        default:
            return MainTableViewSizeConstants.cellHeight
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch sections[section].name {
        case .firstStage, .secondStage:
            if let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MainSectionHeader.identifier) as? MainSectionHeader {
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
            return MainTableViewSizeConstants.stageSectionHeaderHeight
        default:
            return MainTableViewSizeConstants.sectionHeaderHeight
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch sections[section].name {
        case .info, .firstStage:
            return MainTableViewSizeConstants.firstHalfSectionFooterHeight
        case .secondStage, .button:
            return MainTableViewSizeConstants.secondHalfSectionFooterHeight
        }
    }
}
