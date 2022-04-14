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
        if cells.count == 0 {
            return 1
        }
        return cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailsCell.identifier, for: indexPath) as? DetailsCell {
            
            if cells.count == 0 {
                cell.mainLabel.text = "No information available"
                cell.imageView.image = UIImage(systemName: "xmark.circle.fill")
                cell.imageView.tintColor = Color.failureStatus.uiColor
                
                return cell
            }
            
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
