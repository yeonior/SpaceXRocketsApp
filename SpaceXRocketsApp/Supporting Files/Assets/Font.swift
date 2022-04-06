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

    case containerHeader
    case tableCellTitle
    case tableCellDetailTitle
    case tableSectionHeader
    case showButton

    var uiFont: UIFont {
        switch self {
        case .containerHeader:
            return UIFont(name: "LabGrotesque-\(Style.regular.rawValue)", size: 32)!
        case .tableCellTitle:
            return UIFont(name: "LabGrotesque-\(Style.regular.rawValue)", size: 16)!
        case .tableCellDetailTitle:
            return UIFont(name: "LabGrotesque-\(Style.medium.rawValue)", size: 16)!
        case .tableSectionHeader:
            return UIFont(name: "LabGrotesque-\(Style.bold.rawValue)", size: 16)!
        case .showButton:
            return UIFont(name: "LabGrotesque-\(Style.bold.rawValue)", size: 18)!
        }
    }
}
