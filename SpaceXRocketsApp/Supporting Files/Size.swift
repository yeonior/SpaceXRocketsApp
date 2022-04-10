//
//  Size.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 10.04.2022.
//

import UIKit

enum Size {
    case screenWidth
    case screenHeight
    
    var floatValue: CGFloat {
        switch self {
        case .screenWidth:
            return UIScreen.main.bounds.size.width
        case .screenHeight:
            return UIScreen.main.bounds.size.height
        }
    }
}
