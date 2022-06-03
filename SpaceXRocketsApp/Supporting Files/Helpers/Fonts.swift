//
//  Fonts.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 06.04.2022.
//

import UIKit.UIFont

enum Fonts {
    private enum Style: String {
        case thin       = "Thin"
        case regular    = "Regular"
        case medium     = "Medium"
        case bold       = "Bold"
    }

    case mainViewHeader
    
    case mainCollectionCellMainLabel
    case mainCollectionCellDetailsLabel
    
    case tableViewStageSectionHeader
    case tableViewCellMainLabel
    case tableViewCellDetailsLabel
    case tableViewCellUnitLabel
    
    case showButton
    
    case detailsCollectionCellMainLabel
    case detailsCollectionCellDetailLabel
    
    // MARK: - Properties
    var uiFont: UIFont {
        switch self {
        case    .mainViewHeader:
            return UIFont(name: "LabGrotesque-\(Style.regular.rawValue)", size: 32)!
            
        case    .tableViewCellMainLabel,
                .detailsCollectionCellDetailLabel:
            return UIFont(name: "LabGrotesque-\(Style.regular.rawValue)", size: 16)!
            
        case    .tableViewCellDetailsLabel:
            return UIFont(name: "LabGrotesque-\(Style.medium.rawValue)", size: 16)!
            
        case    .mainCollectionCellMainLabel,
                .tableViewStageSectionHeader,
                .tableViewCellUnitLabel:
            return UIFont(name: "LabGrotesque-\(Style.bold.rawValue)", size: 16)!
            
        case    .showButton:
            return UIFont(name: "LabGrotesque-\(Style.bold.rawValue)", size: 18)!
            
        case    .detailsCollectionCellMainLabel:
            return UIFont(name: "LabGrotesque-\(Style.regular.rawValue)", size: 20)!
            
        case    .mainCollectionCellDetailsLabel:
            return UIFont(name: "LabGrotesque-\(Style.regular.rawValue)", size: 14)!
        }
        
    }
}
