//
//  Color.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 06.04.2022.
//

import UIKit.UIColor

enum Color {
    case background
    case mainBackground
    case lauchesPageBackground
    
    case pageIndicator
    case currentPageIndicator
    
    case mainViewHeader
    case mainViewHeaderBackground
    
    case dragIndicator
    case dragIndicatorBackground
    
    case mainCollectionCellMainLabel
    case mainCollectionCellDetailsLabel
    
    case tableViewStageSectionHeader
    case tableViewCellMainLabel
    case tableViewCellDetailsLabel
    case tableViewCellUnitLabel
    case tableViewCellBackground
    
    case showButton
    case showButtonText
    
    case detailsCollectionCellMainLabel
    case detailsCollectionCellDetailsLabel
    case detailsCollectionCellImageView
    case detailsCollectionCellBackground
    case detailsCollectionViewCellCircleBackground
    
    case successStatus
    case failureStatus
    
    case activityIndicatorView
    
    var uiColor: UIColor {
        switch self {
        case    .mainBackground,
                .lauchesPageBackground,
                .mainViewHeaderBackground,
                .tableViewCellBackground:
            return hexStringToUIColor(hex: "#000000")
            
        case    .showButton,
                .detailsCollectionCellBackground:
            return hexStringToUIColor(hex: "#212121")
            
        case    .tableViewCellMainLabel:
            return hexStringToUIColor(hex: "#CACACA")
            
        case    .mainViewHeader,
                .tableViewStageSectionHeader,
                .tableViewCellDetailsLabel,
                .showButtonText:
            return hexStringToUIColor(hex: "#F6F6F6")
            
        case    .pageIndicator,
                .dragIndicator,
                .mainCollectionCellDetailsLabel,
                .tableViewCellUnitLabel,
                .detailsCollectionCellDetailsLabel,
                .detailsCollectionCellImageView:
            return hexStringToUIColor(hex: "#8E8E8F")
            
        case    .background,
                .dragIndicatorBackground:
            return hexStringToUIColor(hex: "#121212")
            
        case    .currentPageIndicator,
                .mainCollectionCellMainLabel,
                .detailsCollectionCellMainLabel,
                .detailsCollectionViewCellCircleBackground,
                .activityIndicatorView:
            return hexStringToUIColor(hex: "#FFFFFF")
            
        case .successStatus:
            return hexStringToUIColor(hex: "#5F9C20")
            
        case .failureStatus:
            return hexStringToUIColor(hex: "#DD473B")
        }
    }
}

extension Color {
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
