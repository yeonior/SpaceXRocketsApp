//
//  MainButtonSectionViewModel.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 12.04.2022.
//

final class MainButtonSectionViewModel: MainSectionViewModelProtocol {
    
    var name: MainSectionType {
        .button
    }
    
    // an empty cell
    var cells: [MainCellViewModelProtocol] {
        [MainCellViewModel()]
    }
}
