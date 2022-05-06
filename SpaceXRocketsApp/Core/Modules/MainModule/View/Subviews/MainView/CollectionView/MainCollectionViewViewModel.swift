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
            
            let heightCell = MainCollectionViewCellViewModel(text: rocket.height.value,
                                                             detailText: rocket.height.unit)
            let diameterCell = MainCollectionViewCellViewModel(text: rocket.diameter.value,
                                                               detailText: rocket.diameter.unit)
            let massCell = MainCollectionViewCellViewModel(text: rocket.mass.value,
                                                           detailText: rocket.mass.unit)
            let payloadCell = MainCollectionViewCellViewModel(text: rocket.payloadWeight.value,
                                                              detailText: rocket.payloadWeight.unit)
            
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
