//
//  MainCollectionViewModel.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 17.04.2022.
//

import UIKit

protocol MainCollectionViewModelProtocol {
    var cells: [MainCollectionCellViewModelProtocol] { get }
}

final class MainCollectionViewModel: NSObject, MainCollectionViewModelProtocol {
    
    // MARK: - Properties
    var cells: [MainCollectionCellViewModelProtocol]
    
    // MARK: - Init
    init(data: [RocketData]) {
        var cells = [MainCollectionCellViewModelProtocol]()
        for rocket in data {
            
            var heightText = ""
            var diameterText = ""
            var payloadText = ""
            
            if let height = rocket.height.feet {
                heightText = String(height)
            } else {
                heightText = "N/A"
            }
            
            if let diameter = rocket.diameter.feet {
                diameterText = String(diameter)
            } else {
                diameterText = "N/A"
            }
            
            if rocket.payloadWeights.first?.id == "leo", let payload = rocket.payloadWeights.first?.lb {
                payloadText = TextFormatter.numberWithCommas(payload)
            } else {
                payloadText = "N/A"
            }
            
            let heightCell = MainCollectionCellViewModel(text: heightText,
                                                   detailText: "Height, ft")
            let diameterCell = MainCollectionCellViewModel(text: diameterText,
                                                   detailText: "Diameter, ft")
            let massCell = MainCollectionCellViewModel(text: TextFormatter.numberWithCommas(rocket.mass.lb),
                                                   detailText: "Mass, lb")
            let payloadCell = MainCollectionCellViewModel(text: payloadText,
                                                   detailText: "Payload, lb")
            cells.append(heightCell)
            cells.append(diameterCell)
            cells.append(massCell)
            cells.append(payloadCell)
        }
        
        self.cells = cells
    }
}

// MARK: - UICollectionViewDataSource
extension MainCollectionViewModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cells.count == 0 ? 1 : cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionCell.identifier, for: indexPath) as? MainCollectionCell {
            
            cell.cellViewModel = cells[indexPath.row]
            
            return cell
        }
        
        return UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainCollectionViewModel: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 96,
                      height: 96)
    }
}
