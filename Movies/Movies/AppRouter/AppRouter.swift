//
//  AppRouter.swift
//  Movies
//
//  Created by DESARROLLO on 6/01/21.
//

import UIKit

class AppRouter {

    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        guard let genresListViewController = GenresListTableViewController.instantiate() else {
            return
        }
        let navigationController = UINavigationController(rootViewController: genresListViewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
