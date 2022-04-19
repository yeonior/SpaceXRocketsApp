//
//  MainCollectionViewViewModel.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 17.04.2022.
//

import UIKit

protocol MainCollectionViewViewModelProtocol {
    var cells: [MainCollectionViewCellViewModelProtocol] { get }
}

struct MainCollectionViewSizeConstants {
    static let cellWidth: CGFloat = 96.0
    static let cellHeight: CGFloat = 96.0
}

final class MainCollectionViewViewModel: NSObject, MainCollectionViewViewModelProtocol {
    
    // MARK: - Properties
    var cells: [MainCollectionViewCellViewModelProtocol]
    
    // MARK: - Init
    init(data: [RocketData]) {
        var cells = [MainCollectionViewCellViewModelProtocol]()
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
            
            let heightCell = MainCollectionViewCellViewModel(text: heightText,
                                                         detailText: "Height, ft")
            let diameterCell = MainCollectionViewCellViewModel(text: diameterText,
                                                           detailText: "Diameter, ft")
            let massCell = MainCollectionViewCellViewModel(text: TextFormatter.numberWithCommas(rocket.mass.lb),
                                                       detailText: "Mass, lb")
            let payloadCell = MainCollectionViewCellViewModel(text: payloadText,
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
extension MainCollectionViewViewModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cells.count == 0 ? 1 : cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as? MainCollectionViewCell {
            
            cell.cellViewModel = cells[indexPath.row]
            
            return cell
        }
        
        return UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainCollectionViewViewModel: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: MainCollectionViewSizeConstants.cellWidth,
                      height: MainCollectionViewSizeConstants.cellHeight)
    }
}
