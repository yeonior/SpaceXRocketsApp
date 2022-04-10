//
//  InfoSectionViewModel.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 10.04.2022.
//

import Foundation

protocol InfoSectionPresentable {
    var rows: [CellIdentifiable] { get set }
}

final class MainInfoSectionViewModel: InfoSectionPresentable {
    var rows: [CellIdentifiable] = []
}
