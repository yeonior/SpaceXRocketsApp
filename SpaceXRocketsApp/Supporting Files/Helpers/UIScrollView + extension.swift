//
//  UIScrollView + extension.swift
//  SpaceXRocketsApp
//
//  Created by Ruslan on 17.04.2022.
//

import UIKit

extension UIScrollView {
    func scrollToTop(animated: Bool) {
        setContentOffset(CGPoint(x: 0, y: -contentInset.top), animated: animated)
    }
    
    func scrollToLeft(animated: Bool) {
        setContentOffset(CGPoint(x: -contentInset.left, y: 0), animated: animated)
    }
}
