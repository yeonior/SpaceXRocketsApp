//
//  MainCollectionCellViewModel.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 17.04.2022.
//

import UIKit

protocol MainCollectionCellViewModelProtocol {
    var text: String? { get }
    var detailText: String? { get }
}

final class MainCollectionCellViewModel: MainCollectionCellViewModelProtocol {
    
    // MARK: - Properties
    var text: String?
    var detailText: String?
    
    // MARK: - Init
    init(text: String, detailText: String) {
        self.text = text
        self.detailText = detailText
    }
}
