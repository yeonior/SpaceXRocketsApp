//
//  DetailsViewModel.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 14.04.2022.
//

import UIKit

protocol DetailsSectionViewModelProtocol {
    var cells: [DetailsCellViewModelProtocol] { get }
}

final class DetailsViewModel: NSObject, DetailsSectionViewModelProtocol {
    var cells: [DetailsCellViewModelProtocol]
    
    init(data: [LaunchModel]) {
        var cells = [DetailsCellViewModelProtocol]()
        for launch in data {
            let cell = DetailsCellViewModel(text: launch.name,
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
extension DetailsViewModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailsCell.identifier, for: indexPath) as? DetailsCell {
            
            cell.cellViewModel = cells[indexPath.row]
            
            return cell
        }
        
        return UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegate
extension DetailsViewModel: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension DetailsViewModel: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 311, height: 100)
    }
}
