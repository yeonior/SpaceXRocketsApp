//
//  MainViewModel.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 11.04.2022.
//

import UIKit

final class MainViewModel: NSObject {
    var items = [MainViewModelItem]()
    
    init(data: RocketData) {
        let info = MainInfoViewModelItem(
            company: data.company,
            country: data.country,
            firstFlight: data.firstFlight
        )
        
        let firstStage = MainFirstStageViewModelItem(
            engines: data.firstStage.engines.value,
            fuelAmountTons: data.firstStage.fuelAmountTons.value,
            burnTimeSEC: data.firstStage.burnTimeSEC.value
        )
        
        let secondStage = MainSecondStageViewModelItem(
            engines: data.secondStage.engines.value,
            fuelAmountTons: data.secondStage.fuelAmountTons.value,
            burnTimeSEC: data.secondStage.burnTimeSEC.value
        )
        
        items.append(info)
        items.append(firstStage)
        items.append(secondStage)
    }
}

// MARK: - UITableViewDataSource
extension MainViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items[section].rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = items[indexPath.section]
        
        switch item.sectionType {
        case .info:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as? MainInfoSectionCell {
                cell.item = item
                return cell
            }
        case .firstStage, .secondStage:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "stageCell", for: indexPath) as? MainStageSectionCell {
                cell.item = item
                return cell
            }
        }
        
        return UITableViewCell()
    }
}

extension MainViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.section == 3 ? 60 : 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0, 3:
            return nil
        default:
            let header = MainTableViewSectionHeader()
            header.titleLabel.text = items[section].sectionType.rawValue
            return header
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
