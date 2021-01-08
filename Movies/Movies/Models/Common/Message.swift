//
//  MessageModel.swift
//  Movies
//
//  Created by DESARROLLO on 7/01/21.
//

import Foundation

struct Message {
    let title: String?
    let description: String?
    let action: ButtonItem?

    enum ButtonItem {
        case reloadData
        case notResult

        var title: String {
            switch self {
            case .reloadData:
                return "Retry"
            case .notResult:
                return "Other Search"
            }
        }
    }
}
