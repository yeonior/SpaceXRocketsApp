//
//  Font.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 06.04.2022.
//

import UIKit.UIFont

enum Font {
    enum Style: String {
        case thin = "Thin"
        case regular = "Regular"
        case medium = "Medium"
        case bold = "Bold"
    }

    case bottomSheetViewHeader
    case tableViewCellMainLabel
    case tableViewCellDetailsLabel
    case tableViewCellUnitLabel
    case tableViewStageSectionHeader
    case showButton
    case collectionCellMainLabel
    case collectionCellDetailLabel

    var uiFont: UIFont {
        switch self {
        case .bottomSheetViewHeader:
            return UIFont(name: "LabGrotesque-\(Style.regular.rawValue)", size: 32)!
        case .tableViewCellMainLabel, .collectionCellDetailLabel:
            return UIFont(name: "LabGrotesque-\(Style.regular.rawValue)", size: 16)!
        case .tableViewCellDetailsLabel:
            return UIFont(name: "LabGrotesque-\(Style.medium.rawValue)", size: 16)!
        case .tableViewStageSectionHeader, .tableViewCellUnitLabel:
            return UIFont(name: "LabGrotesque-\(Style.bold.rawValue)", size: 16)!
        case .showButton:
            return UIFont(name: "LabGrotesque-\(Style.bold.rawValue)", size: 18)!
        case .collectionCellMainLabel:
            return UIFont(name: "LabGrotesque-\(Style.regular.rawValue)", size: 20)!
        }
    }
}
