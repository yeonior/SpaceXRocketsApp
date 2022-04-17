//
//  DetailsCollectionCellViewModel.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 14.04.2022.
//

protocol DetailsCollectionCellViewModelProtocol {
    var text: String? { get }
    var detailText: String? { get }
    var sign: Bool? { get }
}

final class DetailsCollectionCellViewModel: DetailsCollectionCellViewModelProtocol {
    
    // MARK: - Properties
    var text: String?
    var detailText: String?
    var sign: Bool?
    
    // MARK: - Init
    init() {
        self.text = nil
        self.detailText = nil
        self.sign = nil
    }
    
    init(text: String, detailText: String, sign: Bool? = nil) {
        self.text = text
        self.detailText = detailText
        self.sign = sign
    }
}
