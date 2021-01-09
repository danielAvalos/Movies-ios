//
//  MoviesListRouter.swift
//  Movies
//
//  Created by DESARROLLO on 7/01/21.
//

import Foundation

protocol MoviesListRoutingLogic {
    func navigateToMovieDetail(id: Int)
}

// MARK: - MoviesListRoutingLogic

final class MoviesListRouter: NSObject, MoviesListRoutingLogic {

    weak var viewController: MoviesListViewController?

    func  navigateToMovieDetail(id: Int) {
        guard let navigationController = viewController?.navigationController,
              let controller = MovieDetailViewController.instantiate() as? MovieDetailViewController else {
            return
        }
        controller.interactor?.id = id
        navigationController.pushViewController(controller, animated: true)
    }
}
