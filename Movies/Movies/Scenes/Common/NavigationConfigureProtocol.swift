//
//  NavigationConfigureProtocol.swift
//  Movies
//
//  Created by DESARROLLO on 8/01/21.
//

import UIKit

@objc protocol NavigationConfigureProtocol {
    func didTapBarItem(sender: UIBarButtonItem)
}

extension NavigationConfigureProtocol where Self: UIViewController {
    func showActivityIndicator() {
        let activityIndicatorView = UIActivityIndicatorView(style: .medium)
        activityIndicatorView.startAnimating()
        let activityIndicatorBarButtonItem = UIBarButtonItem(customView: activityIndicatorView)
        navigationItem.rightBarButtonItem = activityIndicatorBarButtonItem
    }

    func showRightBarButtonItems(navigationItem: UINavigationItem, items: [BarButtonItemTag]) {
        let items = getBarButtonItems(items: items)
        navigationItem.rightBarButtonItems = nil
        navigationItem.rightBarButtonItems = items
    }

    func showLeftBarButtonItems(navigationItem: UINavigationItem, items: [BarButtonItemTag]) {
        let items = getBarButtonItems(items: items)
        navigationItem.leftBarButtonItems = nil
        navigationItem.leftBarButtonItems = items
    }

    private func getBarButtonItems(items: [BarButtonItemTag]) -> [UIBarButtonItem]? {
        var barButtonItems: [UIBarButtonItem] = [UIBarButtonItem]()
        for item in items {
            let action = UIBarButtonItem(title: item.title, style: .plain, target: self, action: #selector(didTapBarItem))
            action.tag = item.rawValue
            action.tintColor = UIColor.color(named: .orange)
            barButtonItems.append(action)
        }
        return barButtonItems
    }
}
