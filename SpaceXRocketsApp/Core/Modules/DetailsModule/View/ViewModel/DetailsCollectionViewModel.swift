//
//  DetailsCollectionViewModel.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 14.04.2022.
//

import UIKit

protocol DetailsCollectionViewModelProtocol {
    var cells: [DetailsCollectionCellViewModelProtocol] { get }
}

final class DetailsCollectionViewModel: NSObject, DetailsCollectionViewModelProtocol {
    
    // MARK: - Properties
    var cells: [DetailsCollectionCellViewModelProtocol]
    
    // MARK: - Init
    init(data: [LaunchModel]) {
        var cells = [DetailsCollectionCellViewModelProtocol]()
        for launch in data {
            let cell = DetailsCollectionCellViewModel(text: launch.name,
                                                      detailText: TextFormatter.convertDateFormat(date: launch.dateLocal,
                                                                                                  from: .yyyyMMddTHHmmssZ,
                                                                                                  to: .MMMMdyyyy),
                                                      sign: launch.success)
            cells.append(cell)
        }
        
        self.cells = cells
    }
}

// MARK: - UICollectionViewDataSource
extension DetailsCollectionViewModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // "1" for rockets with no launches to show an information cell
        cells.count == 0 ? 1 : cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailsCollectionCell.identifier, for: indexPath) as? DetailsCollectionCell {
            
            // an information cell for rockets with no launches
            if cells.count == 0 {
                cell.mainLabel.text = "No information available"
                cell.imageView.image = UIImage(systemName: "xmark.circle.fill")
                cell.imageView.tintColor = Colors.failureStatus.uiColor
                
                return cell
            }
            
            cell.cellViewModel = cells[indexPath.row]
            
            return cell
        }
        
        return UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension DetailsCollectionViewModel: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: DetailsViewSizeConstants.collectionViewItemWidth,
                      height: DetailsViewSizeConstants.collectionViewItemHeight)
    }
}
