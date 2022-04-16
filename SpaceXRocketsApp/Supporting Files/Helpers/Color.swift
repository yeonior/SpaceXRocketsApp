//
//  Color.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 06.04.2022.
//

import UIKit.UIColor

enum Color {
    case background
    case bottomSheetViewBackground
    case showButton
    case showButtonText
    case tableViewCellMainLabel
    case tableViewCellDetailsLabel
    case tableViewCellUnitLabel
    case bottomSheetViewHeader
    case tableViewStageSectionHeader
    case dragIndicator
    case dragIndicatorBackground
    case currentPageIndicator
    case pageIndicator
    case tableViewCellBackground
    case collectionCellBackground
    case collectionCellMainLabel
    case collectionCellDetailsLabel
    case collectionCellImageView
    case lauchesPageBackground
    case successStatus
    case failureStatus
    case unknownStatus
    case circleBackground
    
    var uiColor: UIColor {
        switch self {
        case
                .bottomSheetViewBackground,
                .tableViewCellBackground,
                .lauchesPageBackground:
            return hexStringToUIColor(hex: "#000000")
            
        case
                .showButton,
                .collectionCellBackground:
            return hexStringToUIColor(hex: "#212121")
            
        case
                .tableViewCellMainLabel:
            return hexStringToUIColor(hex: "#CACACA")
            
        case
                .tableViewCellDetailsLabel,
                .bottomSheetViewHeader,
                .tableViewStageSectionHeader,
                .showButtonText:
            return hexStringToUIColor(hex: "#F6F6F6")
            
        case
                .dragIndicator,
                .pageIndicator,
                .tableViewCellUnitLabel,
                .collectionCellDetailsLabel,
                .collectionCellImageView:
            return hexStringToUIColor(hex: "#8E8E8F")
            
        case
                .background,
                .dragIndicatorBackground:
            return hexStringToUIColor(hex: "#121212")
            
        case
                .currentPageIndicator,
                .collectionCellMainLabel,
                .circleBackground:
            return hexStringToUIColor(hex: "#FFFFFF")
            
        case .successStatus:
            return hexStringToUIColor(hex: "#5F9C20")
            
        case .failureStatus:
            return hexStringToUIColor(hex: "#DD473B")
            
        case .unknownStatus:
            return hexStringToUIColor(hex: "#555555")
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
