//
//  UIColor+Brand.swift
//  Movies
//
//  Created by DESARROLLO on 8/01/21.
//

import UIKit

enum ColorsCustomized: String {
    case black = "blackColor"
    case green =  "greenColor"
    case orange = "orangeColor"
    case red = "redColor"
    case white = "whiteColor"
    case yellow = "yellowColor"
    case grayLightColor = "grayLightColor"
}

extension UIColor {

    static func color(named: ColorsCustomized) -> UIColor? {
        return UIColor(named: named.rawValue)
    }
}
