//
//  Color.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 06.04.2022.
//

import UIKit.UIColor

enum Color {
    case background
    case containerBackground
    case showButton
    case tableCellTitle
    case tableCellDetailTitle
    case containerHeader
    case tableSectionHeader
    case dragIndicator
    case indicatorBackground
    case currentPageIndicator
    case pageIndicator
    case tableCell
    
    var uiColor: UIColor {
        switch self {
        case .containerBackground, .tableCell:
            return hexStringToUIColor(hex: "#000000")
        case .showButton:
            return hexStringToUIColor(hex: "#212121")
        case .tableCellTitle:
            return hexStringToUIColor(hex: "#CACACA")
        case .tableCellDetailTitle, .containerHeader, .tableSectionHeader:
            return hexStringToUIColor(hex: "#F6F6F6")
        case .dragIndicator, .pageIndicator:
            return hexStringToUIColor(hex: "#8E8E8F")
        case .background, .indicatorBackground:
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
