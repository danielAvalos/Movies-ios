//
//  BarButtonItemTag.swift
//  Movies
//
//  Created by DESARROLLO on 8/01/21.
//

import Foundation

enum BarButtonItemTag: Int {
    case categories
    case sort
    case share

    var title: String {
        switch self {
        case .categories:
            return "Categories"
        case .sort:
            return "Sort"
        case .share:
            return "Share"
        }
    }
}
