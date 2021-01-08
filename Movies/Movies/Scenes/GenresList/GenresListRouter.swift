//
//  GenresListRouter.swift
//  Movies
//
//  Created by DESARROLLO on 6/01/21.
//

import Foundation

protocol GenresListRoutingLogic {
    func navigateToMoviesByGenre(id: Int)
}

// MARK: - GenresListRoutingLogic

final class GenresListRouter: NSObject, GenresListRoutingLogic {

    weak var viewController: GenresListTableViewController?

    func  navigateToMoviesByGenre(id: Int) {
        guard let navigationController = viewController?.navigationController,
              let controller = MoviesListViewController.instantiate() as? MoviesListViewController else {
            return
        }
        controller.interactor?.genreId = id
        navigationController.pushViewController(controller, animated: true)
    }
}
