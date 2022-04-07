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
    
    var uiColor: UIColor {
        switch self {
        case .bottomSheetViewBackground, .tableViewCellBackground:
            return hexStringToUIColor(hex: "#000000")
        case .showButton:
            return hexStringToUIColor(hex: "#212121")
        case .tableViewCellMainLabel:
            return hexStringToUIColor(hex: "#CACACA")
        case .tableViewCellDetailsLabel, .bottomSheetViewHeader, .tableViewStageSectionHeader:
            return hexStringToUIColor(hex: "#F6F6F6")
        case .dragIndicator, .pageIndicator, .tableViewCellUnitLabel:
            return hexStringToUIColor(hex: "#8E8E8F")
        case .background, .dragIndicatorBackground:
            return hexStringToUIColor(hex: "#121212")
        case .currentPageIndicator:
            return hexStringToUIColor(hex: "#FFFFFF")
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
