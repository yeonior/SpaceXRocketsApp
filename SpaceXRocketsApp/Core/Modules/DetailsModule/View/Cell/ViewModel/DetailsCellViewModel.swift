//
//  DetailsCellViewModel.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 14.04.2022.
//

protocol DetailsCellViewModelProtocol {
    var text: String? { get }
    var detailText: String? { get }
    var sign: Bool? { get }
}

final class DetailsCellViewModel: DetailsCellViewModelProtocol {
    
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
