//
//  UIViewController + extension.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 17.04.2022.
//

import UIKit

extension UIViewController {
    var navigationBarHeight: CGFloat {
        return navigationController?.navigationBar.frame.height ?? 0.0
    }
    
    var bottomSafeAreaHeight: CGFloat {
        return UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0.0
    }
}
